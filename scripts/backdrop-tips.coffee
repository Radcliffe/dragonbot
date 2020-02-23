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

module.exports = (robot) ->

  tips = [
    'You can communicate with me (@Dragonbot) in a private channel',
    'Check out the "Needs Help" stream for issues that other community members need help with',
    'Every Wednesday we have office hours in our chat channels for new contributors or Backdrop CMS users - https://backdropcms.org/support/resources',
    'Have you signed up for our newsletter yet? - https://backdropcms.org/newsletter',
    'For more information about the Backdrop CMS Project Management Committee - https://backdropcms.org/leadership',
    'The Backdrop CMS Mission is: "Backdrop CMS enables people to build highly customized websites affordably, through collaboration and open source software."',
    'Backdrop CMS principle #1 - "Easier updates: Backwards compatibility is important." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #2 - "Simplicity: Write code for the majority." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #3 - "Focus: Include features for the majority. " - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #4 - "Extensibility: Ensure Backdrop can be extended." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #5 - "Security: Keep sites and people safe." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #6 - "Speed and performance: Meet low system requirements." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #7 - "Release on-time: Plan and schedule releases." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle #8 - "Freedom: Remain Free and Open Source." - https://backdropcms.org/philosophy',
    'final tip'
  ]

  robot.hear /tips/i, (res) ->
    res.send "Here is a random Backdrop CMS community tip"
    res.send res.random tips
