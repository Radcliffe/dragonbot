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

  robot.respond /member list/i, (res) ->
    participantList = robot.brain.get('bdMembers')
    res.send "Here is the list:"
    res.send participantList

  robot.hear /badger/i, (res) ->
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

  robot.hear /code of conduct/i, (res) ->
    res.send "https://github.com/backdrop-ops/conduct/blob/master/code_of_conduct.md"

  robot.hear /wordpress/i, (res) ->
    dice = Math.floor(Math.random() * 15) + 1
    if dice == 3
      res.send "Is someone talking about Wordpress again? "

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
    'Oh no, I think I have had too much today :sick:',
    'Backdrop humans are so generous. Thanks!',
    'Are you volunteering?',
    'Do you happen to have a pickle?',
    'Anything, as long as there are no olives on it.',
    'I don\'t mind if I do.',
    'Are you trying to curry favor with me?',
    'Are you talking to me?',
    ':cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: :cookie: - Is that enough for everyone?'
  ]

  robot.hear /botsnack/i, (res) ->
    res.send res.random botsnack

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

  robot.hear /color (\w+)/i, (res) ->
    myColor = res.match[1]
    colorList = robot.brain.get('colorList') || [];
    colorList.unshift myColor
    res.send colorList
    robot.brain.set 'colorList', [colorList]

  robot.hear /admin clear color/i, (res) ->
    robot.brain.set 'colorList', []
    res.send "Color list cleared."

  robot.hear /admin clear users/i, (res) ->
    robot.brain.set 'bdMembers', []
    res.send "User list cleared."
    res.finish()

  robot.hear /.*/i, (mes) ->
    participants = robot.brain.get('bdMembers') || [];
    if participants
      if mes.message.user.id not in participants
        participants.unshift mes.message.user.id
        robot.brain.set 'bdMembers', participants
        mes.send "I think this is your first time posting today."
        mes.send "This is just a short term test feature."

#  robot.listen(
#    (message) -> # Match function
      # Occassionally respond to things that Steve says
#      message.user.name is "StPaulTim" and Math.random() > 0.8
#    (response) -> # Standard listener callback
      # Let Steve know how happy you are that he exists
#      response.reply "HI STEVE! YOU'RE MY BEST FRIEND! (but only like #{response.match * 100}% of the time)"
#  )
