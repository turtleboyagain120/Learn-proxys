export default function move_forward(bot, game) {
    bot.velocity.add(new THREE.Vector3(0, 0, -0.3).applyQuaternion(bot.quaternion));
    bot.position.add(bot.velocity);
    bot.velocity.multiplyScalar(0.8); // Friction
}
