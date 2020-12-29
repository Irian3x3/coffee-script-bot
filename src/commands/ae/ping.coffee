module.exports =
    name: "e"
    exec: (message, args, bot) ->
        message.channel.send "api: #{bot.ws.ping} ms :/"