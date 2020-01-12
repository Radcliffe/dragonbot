# Description:
#   Custom scripts for Backdrop CMS community.
#
# These commands are supplements for other scripts as well
#
# Commands:
#

module.exports = (robot) ->

# Admin commands to clear data or prints lists

  robot.hear /admin show users/i, (res) ->
    participantList = robot.brain.get('bdMembers')
    res.send "Here is the user list:"
    res.send participantList

  robot.hear /admin show colors/i, (res) ->
    colorList = robot.brain.get('colorList')
    res.send "Here is the color list:"
    res.send colorList

  robot.hear /admin clear users/i, (res) ->
    robot.brain.set 'bdMembers', []
    res.send "User list cleared."
    res.finish()

  robot.hear /admin clear colors/i, (res) ->
    robot.brain.set 'colorList', []
    res.send "Color list cleared."

  robot.hear /.*/i, (mes) ->
    participants = robot.brain.get('bdMembers') || [];
    if participants
      if mes.message.user.id not in participants
        participants.unshift mes.message.user.id
        robot.brain.set 'bdMembers', participants

  robot.hear /color (\w+)/i, (res) ->
    myColor = res.match[1]
    colorList = robot.brain.get('colorList') || [];
    colorList.unshift myColor
    robot.brain.set 'colorList', colorList
    res.send myColor
    res.send colorList
    temp = mes.message.user.id
    res.send temp




  
