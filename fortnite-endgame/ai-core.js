let behaviorModules = [];

export async function initAI(game) {
    // Load 1000+ tiny behavior scripts dynamically (example loads 20, scale up)
    const behaviors = [
        'scripts/ai/move-forward.js',
        'scripts/ai/rotate-left.js',
        'scripts/ai/build-wall.js',
        'scripts/ai/edit-window.js',
        'scripts/ai/zone-toward.js',
        'scripts/ai/layer-up.js',
        'scripts/ai/break-floor.js',
        'scripts/ai/peek-rotate.js',
        'scripts/ai/crouch-build.js',
        'scripts/ai/edge-zone.js',
        'scripts/ai/piece-control.js',
        'scripts/ai/cone-rotate.js',
        'scripts/ai/triple-edit.js',
        'scripts/ai/offspawn-build.js',
        'scripts/ai/pressure-build.js',
        'scripts/ai/retreat-layer.js',
        'scripts/ai/offensive-zone.js',
        'scripts/ai/defensive-wall.js',
        'scripts/ai/micro-rotate.js',
        'scripts/ai/quick-floor.js'
        // Add 980+ more similar files for total >1000
    ];

    behaviorModules = await Promise.all(
        behaviors.map(path => import(path).catch(() => ({})))
    );

    // Create 20 bots
    for (let i = 0; i < 20; i++) {
        game.bots.push(createBot(game.scene, game));
    }

    // AI tick
    setInterval(() => updateBots(game), 50); // 20 FPS for micro-actions
}

function createBot(scene, game) {
    const botGroup = new THREE.Group();

    // Bot model (simple capsule)
    const body = new THREE.Mesh(
        new THREE.CapsuleGeometry(0.3, 1.5),
        new THREE.MeshLambertMaterial({ color: Math.random() * 0xffffff })
    );
    body.castShadow = true;
    botGroup.add(body);

    // Preview build piece
    botGroup.buildPiece = new THREE.Mesh(
        new THREE.BoxGeometry(1, 0.2, 1),
        new THREE.MeshBasicMaterial({ color: 0x888888, transparent: true, opacity: 0.8 })
    );
    botGroup.buildPiece.visible = false;
    botGroup.add(botGroup.buildPiece);

    botGroup.position.set(
        (Math.random() - 0.5) * 40,
        1,
        (Math.random() - 0.5) * 40
    );
    botGroup.state = 'idle';
    botGroup.health = 100;
    botGroup.rotation.y = Math.random() * Math.PI * 2;
    botGroup.velocity = new THREE.Vector3();
    botGroup.behaviorQueue = [];
    scene.add(botGroup);

    return botGroup;
}

function updateBots(game) {
    game.bots.forEach(bot => {
        // Zone pressure
        const toCenter = new THREE.Vector3(0,0,0).sub(bot.position);
        const zonePressure = toCenter.length() > game.zone.size / 2 ? 1 : 0.1;

        // Select behavior based on state/pressure (advanced FSM)
        if (Math.random() < zonePressure) {
            bot.behaviorQueue.unshift('zone-toward');
        } else if (Math.random() < 0.3) {
            bot.behaviorQueue.unshift(pickRandomBehavior());
        }

        if (bot.behaviorQueue.length > 0) {
            executeBehavior(bot, bot.behaviorQueue.shift(), game);
        }

        // Physics: gravity, zone damage
        bot.position.y -= 0.1; // Simplified gravity
        if (bot.position.y < 1) bot.position.y = 1;
        if (toCenter.length() > game.zone.size / 2) bot.health -= 0.5;

        // Rotation smoothing
        bot.rotation.y += (bot.targetRotation - bot.rotation.y) * 0.1;
    });
}

function pickRandomBehavior() {
    const behaviors = ['build-wall', 'edit-window', 'rotate-left', 'layer-up', 'peek-rotate'];
    return behaviors[Math.floor(Math.random() * behaviors.length)];
}

function executeBehavior(bot, behavior, game) {
    // Map to loaded modules (simplified dispatcher)
    const modIndex = behaviorModules.findIndex(m => m.default &amp;&amp; m.default.name === behavior.replace('-', '_'));
    if (modIndex !== -1) {
        behaviorModules[modIndex].default(bot, game);
    }
    // Fallback simple actions
    switch (behavior) {
        case 'move-forward':
            bot.velocity.add(new THREE.Vector3(0,0,-0.2).applyQuaternion(bot.quaternion));
            break;
        case 'rotate-left':
            bot.targetRotation -= 0.1;
            break;
        case 'build-wall':
            buildStructure(bot, game, 'wall');
            break;
    }
}

function buildStructure(bot, game, type) {
    const pos = bot.position.clone().add(new THREE.Vector3(0,1, -2).applyQuaternion(bot.quaternion));
    const geo = new THREE.BoxGeometry(1, 4, 1);
    const mat = new THREE.MeshLambertMaterial({ color: 0x654321 });
    const structure = new THREE.Mesh(geo, mat);
    structure.position.copy(pos);
    structure.castShadow = true;
    structure.receiveShadow = true;
    game.scene.add(structure);
    game.buildings.push(structure);

    // Preview effect
    bot.buildPiece.visible = true;
    bot.buildPiece.position.copy(pos);
    setTimeout(() => bot.buildPiece.visible = false, 100);
}

// Raycast for editing/breaking (advanced)
function raycastEdit(bot, game, editType) {
    const raycaster = new THREE.Raycaster(bot.position.clone().add(new THREE.Vector3(0,1.5,0)), 
        new THREE.Vector3(0,0,-1).applyQuaternion(bot.quaternion));
    const intersects = raycaster.intersectObjects(game.buildings);
    if (intersects.length > 0) {
        const hit = intersects[0].object;
        if (editType === 'break') {
            game.scene.remove(hit);
            game.buildings = game.buildings.filter(b => b !== hit);
        } else {
            // Edit: resize to window
            hit.scale.set(0.8, 0.8, 0.1);
            hit.material.color.setHex(0xaaaaaa);
        }
    }
}
