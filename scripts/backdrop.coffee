# Description:
#   A custom script to manage Backdrop CMS business on Zulip.
#
# These commands are supplements for other scripts as well
#
# Commands:
#   bd add member
#

backdropMembers = {}

module.exports = (robot) ->

  robot.hear /.*/i, (mes) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    member = mes.message.user.id
    if !backdropMembers[member]
      backdropMembers[member] = {
        name: mes.message.user.name, 
        dateJoined: new Date(), 
        dateLastVisit: new Date()
      }
      message = 
      """
        Hi. Welcome to the Backdrop CMS community on Zulip. I'm your friendly neighborhood Dragonbot.
        Try \'@Dragonbot help\' for some things I can do. 
        There are lots of friendly humans that hang around here, so please feel free to ask questions.
      """
      # mes.send message
    else
      backdropMembers[member] = {dateJoined: new Date(), dateLastVisit: new Date()}
    robot.brain.set 'backdropMembers', backdropMembers

  robot.hear /bd add member ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (\w+)/i, (res) ->
    memberID = res.match[1]
    memberName = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if !backdropMembers[memberID]
      backdropMembers[memberID] = {name: memberName, dateJoined: new Date()}
      robot.brain.set 'backdropMembers', backdropMembers
      res.send "#{memberID} added"
    else 
      res.send "#{memberID} already exists."

  robot.hear /bd update member ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (.+)/i, (res) ->
    memberID = res.match[1]
    memberName = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    backdropMembers[memberID] = {name: memberName, dateJoined: new Date()}
    robot.brain.set 'backdropMembers', backdropMembers
    res.send "#{memberID} added"

  robot.hear /bd add issue ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (\S+)/i, (res) ->
    member = res.match[1]
    issuePath = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if backdropMembers[member]
      backdropMembers[member].issue = {issuePath: issuePath, dateCreated: new Date()}
      robot.brain.set 'backdropMembers', backdropMembers
      res.send JSON.stringify backdropMembers 

  robot.hear /bd show issues/i, (res) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    for own member, data of backdropMembers
      if data.issue
        res.send "#{member} : #{data.issue.issuePath}"

  robot.hear /bd show members/i, (res) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    res.send "Here is a list of all members"
    for own member, data of backdropMembers
      res.send "#{data.name} : #{data.dateJoined}"

  robot.hear /bd show member json/i, (res) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    res.send JSON.stringify backdropMembers


