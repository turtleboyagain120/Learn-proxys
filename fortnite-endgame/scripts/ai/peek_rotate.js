export default function peek_rotate(bot) {
    bot.targetRotation += Math.PI / 6;
    setTimeout(() => bot.targetRotation -= Math.PI / 6, 200);
}
