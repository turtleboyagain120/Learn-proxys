export default function crouch_build(bot, game) {
    bot.position.y -= 0.5;
    setTimeout(() => bot.position.y += 0.5, 500);
    buildStructure(bot, game, 'wall');
}
