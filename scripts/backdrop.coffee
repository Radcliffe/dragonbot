# Description:
#   Custom scripts for Backdrop CMS community.
#
# These commands are supplements for other scripts as well
#
# Commands:
#   hubot karma best [n] - top [n]
#   hubot karma worst [n] - bottom [n]
#   [item]++ or [user]++ | Adds karma
#


module.exports = (robot) ->

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

  robot.respond /open the (.*) doors/i, (res) ->
    doorColor = "red"
    doorType = res.match[1]
    if doorType is "pod bay"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{doorColor} #{doorType} doors"

  robot.respond /have a soda/i, (res) ->
    sodasHad = robot.brain.get('totalSodas') * 1 or 0
    if sodasHad > 4
      res.reply "I'm too fizzy.."
    else
      res.reply "How refreshing"
      res.reply sodasHad  
      robot.brain.set 'totalSodas', sodasHad+1

  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    res.send 'zzzzz'
    res.finish()

#  robot.listen(
#    (message) -> # Match function
      # Occassionally respond to things that Steve says
#      message.user.name is "StPaulTim" and Math.random() > 0.8
#    (response) -> # Standard listener callback
      # Let Steve know how happy you are that he exists
#      response.reply "HI STEVE! YOU'RE MY BEST FRIEND! (but only like #{response.match * 100}% of the time)"
#  )
