{ Client, Collection } = require('discord.js');
config = require "./config"
{ compile } = require 'coffeescript';

bot = new Client disableMentions: "everyone"

bot.commands = new Collection()

{ readdirSync } = require 'fs';
{ join } = require 'path';

a = readdirSync join "dist", config.commandDir

for folder of a
    inside = readdirSync(join("dist", config.commandDir, folder)).filter (file) -> file.endsWith(".js")
    for commandFile of inside
        commandInfo = require join('dist', config.commandDir, folder, commandFile)
        bot.commands.set commandInfo.name, commandInfo

bot.login config.token

bot.on "ready", () ->
    console.log 'Online'

bot.on "message", (message) ->
    return if not message.content.startsWith config.prefix
    args = message.content.slice(config.prefix.length).trim().split(/ +/)
    commandName = args.shift().toLowerCase()

    cmd = bot.commands.get commandName or bot.commands.find (c) -> c.aliases and c.aliases.includes commandName

    if cmd or cmd and cmd.exec
        cmd.exec(message, args, bot).catch console.error

    # message.channel.send "e, #{message.author.tag}!" if command == 'hello'

    # eval compile args.join " " if command == 'eval'



# succ