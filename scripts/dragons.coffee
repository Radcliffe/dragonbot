# Description:
#   Custom scripts for Backdrop CMS community.
#
#
# Commands:

module.exports = (robot) ->

  robot.hear /ted/i, (res) ->
    res.send "What\'s up"

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