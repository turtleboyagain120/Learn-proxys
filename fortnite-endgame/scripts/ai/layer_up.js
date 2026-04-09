export default function layer_up(bot, game) {
    buildStructure(bot, game, 'ramp');
    bot.position.y += 1;
}
