export function initGameEngine(game) {
    game.zone.shrinkTimer = 300;

    // Zone shrink loop
    setInterval(() => {
        if (game.zone.shrinkTimer > 0) {
            game.zone.shrinkTimer -= 1;
            game.zone.size *= (1 - game.zone.shrinkRate / 600);
            // Update zone visual (circle overlay)
            if (game.zoneVisualizer) {
                game.scene.remove(game.zoneVisualizer);
            }
            const zoneGeo = new THREE.RingGeometry(game.zone.size / 2 - 1, game.zone.size / 2, 32);
            const zoneMat = new THREE.MeshBasicMaterial({ color: 0xff0000, transparent: true, opacity: 0.3 });
            game.zoneVisualizer = new THREE.Mesh(zoneGeo, zoneMat);
            game.zoneVisualizer.rotation.x = -Math.PI / 2;
            game.scene.add(game.zoneVisualizer);
        }
    }, 1000);

    // Clutter generation: buildings, trees, etc.
    for (let i = 0; i < 50; i++) {
        const clutter = new THREE.Mesh(
            new THREE.BoxGeometry(Math.random()*3+1, Math.random()*10+5, Math.random()*3+1),
            new THREE.MeshLambertMaterial({ color: new THREE.Color().setHSL(Math.random()*0.1 + 0.45, 0.5, 0.5) })
        );
        clutter.position.set(
            (Math.random() - 0.5) * 50,
            clutter.geometry.parameters.height / 2,
            (Math.random() - 0.5) * 50
        );
        clutter.castShadow = true;
        clutter.receiveShadow = true;
        game.scene.add(clutter);
    }
}
