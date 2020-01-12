# Description:
#   Example scripts for you to examine and try out.
#
# Commands:
#   hubot karma best [n] - top [n]
#   hubot karma worst [n] - bottom [n]
#   [item]++ or [user]++ | Adds karma
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

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

#  robot.hear /joomla/i, (res) ->
#    if Math.random() > 0.9
#      res.send "Is someone talking about Joomla today? "

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

#  robot.listen(
#    (message) -> # Match function
      # Occassionally respond to things that Steve says
#      message.user.name is "StPaulTim" and Math.random() > 0.8
#    (response) -> # Standard listener callback
      # Let Steve know how happy you are that he exists
#      response.reply "HI STEVE! YOU'RE MY BEST FRIEND! (but only like #{response.match * 100}% of the time)"
#  )

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
    res.finish()

  robot.hear /clear color/i, (res) ->
    robot.brain.set 'colorList', []
    res.send "Color list cleared."
    res.finish()

  robot.hear /.*/i, (mes) ->
    participants = robot.brain.get('bdMembers') || [];
    if participants
      if mes.message.user.id not in participants
        participants.unshift mes.message.user.id
      else
        mes.finish()
    robot.brain.set 'bdMembers', participants
  
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
