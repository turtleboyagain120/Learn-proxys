export default function zone_toward(bot, game) {
    const toCenter = new THREE.Vector3(0,0,0).sub(bot.position).normalize();
    bot.targetRotation = Math.atan2(toCenter.x, toCenter.z);
    bot.velocity.add(toCenter.multiplyScalar(0.2));
}
