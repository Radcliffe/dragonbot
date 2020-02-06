# Description:
#   Custom scripts for Backdrop CMS community.
#
#
# Commands:
#   hubot karma best [n] - top [n]
#   hubot karma worst [n] - bottom [n]
#   [item]++ or [user]++ | Adds karma

module.exports = (robot) ->

  botsnack = [
    'Om nom nom', 
    'Oh thx, have a cookie yourself!', 
    'Awww, thanks.', 
    ':apple:', 
    'I love :spaghetti:', 
    ':donut: - donuts for everyone!',
    ':cake: or :pancakes: - which shall I choose?',
    'All I need is :hearts:.',
    'Thanks, but I am good for now.',
    'Backdrop humans are so generous. Thanks!',
    'Are you volunteering?',
    'I don\'t mind if I do.',
    'Are you trying to curry favor with me?',
    ':cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: - Is this enough for everyone?'
  ]

  robot.hear /botsnack/i, (res) ->
    res.send res.random botsnack

  robot.hear /badger/i, (res) ->
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

  robot.hear /code of conduct/i, (res) ->
    res.send "https://github.com/backdrop-ops/conduct/blob/master/code_of_conduct.md"

  robot.hear /wordpress/i, (res) ->
    dice = Math.floor(Math.random() * 15) + 1
    if dice == 3
      res.send "Is someone talking about Wordpress again? "

  robot.respond /hello|hi|greetings|salutations/i, (res) ->
    res.send "Hello, how can I be of service?"
    res.finish()

  # Waits 0-10 seconds before replying
  robot.hear /hello$|hi$|greetings$|salutations$/i, (res) ->
    responseDuration = Math.floor(Math.random() * 10) + 1
    setTimeout ->
      res.send "Hello, how can I help you?"
    , responseDuration * 1000
    res.finish()

  robot.hear /I like pie/i, (res) ->
    res.emote "makes a freshly baked pie"

  robot.hear /\bdragon\b|\bdragons\b/i, (res) ->
    res.emote "Is someone talking about me?"
    res.finish()

  robot.catchAll (msg) ->
    r = new RegExp "^(?:#{robot.alias}|#{robot.name}) (.*)", "i"
    matches = msg.message.text.match(r)
    if matches != null && matches.length > 1
      msg.send 'Sorry, I don\'t understand. Try @Dragonbot help'
    msg.finish()