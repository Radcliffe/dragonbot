# Description:
#   A custom script to manage Backdrop CMS business on Zulip.
#
# These commands are supplements for other scripts as well
#
# Commands:
#   hubot show needs attention - Show a list of issues that need your attention
#   hubot attention - How to add an issue to 'needs attention' list
#   hubot remove issue - Remove your 'needs attetion' issue
#   hubot add issue [IssuePath] - Add an issue to our 'needs attention' list
#   hubot welcome - Shows welcome message

backdropMembers = {}

module.exports = (robot) ->

  welcomeMessage = """
       Welcome to the Backdrop CMS community on Zulip. I'm your friendly neighborhood Dragonbot. Try \'@Dragonbot help\' for a list of things I can help you with. There are lots of friendly humans that hang around here, so please feel free to ask questions. 

       Here is a short (3 min) video to help you navigate Zulip. https://youtu.be/DN8YL2MrsSU
    """

  robot.hear /.*/i, (mes) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    member = mes.message.user.id
    if !backdropMembers[member]
      backdropMembers[member] = {
        name: mes.message.user.name, 
        dateJoined: new Date(), 
        dateLastVisit: new Date()
      }
      mes.send "Hi, #{mes.message.user.name}. #{welcomeMessage}"
    else
      backdropMembers[member].dateLastVisit = new Date()
    robot.brain.set 'backdropMembers', backdropMembers

  robot.respond /welcome/i, (res) ->
    res.send welcomeMessage

  robot.hear /bd add member ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (.+)/i, (res) ->
    memberID = res.match[1]
    memberName = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if !backdropMembers[memberID]
      backdropMembers[memberID] = {
        name: memberName, 
        dateJoined: new Date(),
        dateLastVisit: new Date()
      }
      robot.brain.set 'backdropMembers', backdropMembers
      res.send "#{memberID} added"
    else 
      res.send "#{memberID} already exists."

  robot.hear /bd update member ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (.+)/i, (res) ->
    memberID = res.match[1]
    memberName = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    backdropMembers[memberID].name = memberName
    backdropMembers[memberID].dateLastVisit = new Date()
    robot.brain.set 'backdropMembers', backdropMembers
    res.send "#{memberID} updated"

  robot.hear /bd remove member ([\w-\.]+@([\w-]+\.)+[\w-]{2,4})/i, (res) ->
    memberID = res.match[1]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    delete backdropMembers[memberID]
    robot.brain.set 'backdropMembers', backdropMembers
    res.send "#{memberID} removed"

  robot.respond /add issue (\S+)/i, (res) -> 
    member = res.message.user.id
    issue = res.match[1]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if !backdropMembers[member].issue
      res.send "Added issue: #{issue}"
      backdropMembers[member].issue = {issuePath: issue, dateCreated: new Date()}
    else
      res.send "You already have an issue listed try '@Dragonbot remove issue' and then try again."

  robot.respond /remove issue/i, (res) -> 
    member = res.message.user.id
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if backdropMembers[member].issue
      delete backdropMembers[member].issue
      res.send "Your issue is removed. Try '@dragonbot add issue [PathToIssue]' to add another."
    else
      res.send "You dont' have an issue to remove"

  robot.hear /bd add issue ([\w-\.]+@([\w-]+\.)+[\w-]{2,4}) (\S+)/i, (res) ->
    member = res.match[1]
    issuePath = res.match[3]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if backdropMembers[member]
      backdropMembers[member].issue = {issuePath: issuePath, dateCreated: new Date()}
      robot.brain.set 'backdropMembers', backdropMembers
      res.send JSON.stringify backdropMembers 

  robot.hear /bd remove issue ([\w-\.]+@([\w-]+\.)+[\w-]{2,4})/i, (res) ->
    member = res.match[1]
    backdropMembers = robot.brain.get('backdropMembers') || {};
    if backdropMembers[member]
      delete backdropMembers[member].issue
      robot.brain.set 'backdropMembers', backdropMembers
      res.send JSON.stringify backdropMembers 

  robot.respond /attention|needs attention|show needs attention/i, (res) ->
    message = "Here are some issues that need attention: \n\n"
    backdropMembers = robot.brain.get('backdropMembers') || {};
    for own member, data of backdropMembers
      if data.issue
        message += "#{data.name} : #{data.issue.issuePath} \n"
    message += "\n" 
    message += "Add to list: '@Dragonbot add issue [path]'' \n"
    message += "Remove your issue: '@Dragonbot remove issue' \n" 
    message += "Only one issue per user."  
    res.send message

  robot.hear /bd show members/i, (res) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    message = "Here is a list of all members: \n\n"
    for own member, data of backdropMembers
      message += "#{data.name} : #{member} \n"
    res.send message

  robot.hear /bd show member json/i, (res) ->
    backdropMembers = robot.brain.get('backdropMembers') || {};
    res.send JSON.stringify backdropMembers

  robot.hear /green eggs/i, (res) ->
    room = res.message.room
    robot.messageRoom room, "I do not like green eggs and ham.  I do not like them sam-I-am."




