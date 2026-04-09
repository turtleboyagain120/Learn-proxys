export default function build_wall(bot, game) {
    const pos = bot.position.clone().add(new THREE.Vector3(0, 2, -3).applyQuaternion(bot.quaternion));
    const wall = new THREE.Mesh(new THREE.BoxGeometry(1, 4, 1), new THREE.MeshLambertMaterial({color: 0x8B4513}));
    wall.position.copy(pos);
    wall.castShadow = true;
    game.scene.add(wall);
    game.buildings.push(wall);
}
