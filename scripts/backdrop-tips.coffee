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
#   hubot testing - Just a test change to see how things work

module.exports = (robot) ->

  tips = [
    'You can communicate with me (@Dragonbot) in a private channel',
    'Check out the "Needs Help" stream for issues that other community members need help with',
    'If you use social media, please consider sharing something about Backdrop CMS. It help\'s people find us.',
    'Every Wednesday we have office hours in our chat channels for new contributors or Backdrop CMS users - https://backdropcms.org/support/resources',
    'Have you signed up for our newsletter yet? - https://backdropcms.org/newsletter',
    'For more information about the Backdrop CMS Project Management Committee - https://backdropcms.org/leadership',
    'The Backdrop CMS Mission is: "Backdrop CMS enables people to build highly customized websites affordably, through collaboration and open source software."',
    'Backdrop CMS principle 1 - "Easier updates: Backwards compatibility is important." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 2 - "Simplicity: Write code for the majority." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 3 - "Focus: Include features for the majority. " - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 4 - "Extensibility: Ensure Backdrop can be extended." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 5 - "Security: Keep sites and people safe." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 6 - "Speed and performance: Meet low system requirements." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 7 - "Release on-time: Plan and schedule releases." - https://backdropcms.org/philosophy',
    'Backdrop CMS principle 8 - "Freedom: Remain Free and Open Source." - https://backdropcms.org/philosophy',
    'Never hack core',
    'Become an advocate for an issue in Backdrop CMS core. You don\'t have to fix it yourself. Just help move it forward. Anyone
      can advocate for an issue. https://backdropcms.org/news/become-an-advocate-for-a-new-feature-in-backdrop-core',
    'Please, feel free to join in one of our weekly meetings. We love to see new faces.
      Watch chat channels for more info - https://backdropcms.org/support/resources',
    'Find us on Facebook - https://www.facebook.com/backdropcms',
    'If you use Facebook, share one of our posts - https://www.facebook.com/backdropcms',
    'See what people are saying about Backdrop CMS around the web - https://backdropcms.org/news/mentions',
    'Look for or add Backdrop CMS related events to our calender - https://backdropcms.org/news/events',
    'Backdrop CMS usage statistics - https://backdropcms.org/project/usage',
    'Checkout the Backdrop CMS Youtube channel - meetings, tutorials, etc. - https://www.youtube.com/user/backdropcms/videos',
    'Help us create simple and short "how to" videos for Backdrop CMS - https://www.youtube.com/user/backdropcms/videos',
    'Always be nice to each other',
    'Build a sub-theme of Basis, the default frontend theme of
      Backdrophttps://backdropcms.org/news/build-sub-theme-basis-default-frontend-theme-backdrop',
    'Getting Started with Backdrop and DDEV-Local - https://backdropcms.org/news/getting-started-backdrop-and-ddev-local',
    'There is a weekly developer meeting every Thursday at 1pm (Pacific Time - USA) and fortnightly design and
      outreach meetings every other Thursday at 12noon (Pacific Time - USA).',
    'Here is the information you need to join the Backdrop CMS contrib group. https://backdropcms.org/contribute/join',
    'Here is a list of the top 125 Drupal 7 modules that have been ported to Backdrop CMS. Let us know if this list needs updating.
      https://github.com/backdrop-ops/contrib/issues/34',
    'Here is a list of the many Backdrop CMS related issue queues: https://backdropcms.org/resources/backdrop-cms-github',
    'Have you been to our API site yet - https://api.backdropcms.org/?',
    'We always need content for the Backdrop CMS blog. Please, let us know if you are able to
      help write a blog post. https://backdropcms.org/contact',
    'Follow us on Twitter - https://twitter.com/backdropcms',
    'Pick a contrib module you like and post some feedback in the issue queue for that module. Our module contributors
      would love to hear what you think of their modules and how they can be improved. Every module page has a link to their
      respective issue queue in the right hand column of the module page: https://backdropcms.org/modules',
    'See our "Services Providers" page or add yourself - https://backdropcms.org/support/services',
    'Add your Backdrop CMS project to the community showcase - https://backdropcms.org/showcase',
    'Most recently released OR updated modules are displayed at the top: https://backdropcms.org/modules',
    'Contribute to open source - as much as possible',
    'Never forget to "Clear the cache"',
    'Here are a few ways you can contribute to Backdrop CMS - https://backdropcms.org/contribute',
    'Backdrop CMS release cycle - https://backdropcms.org/releases',
    'Check the forum to see if there are any questions you can answer or contribute to?',
    'Here is a list of Backdrop CMS Core issues that need your feedback. Pick one out, read through the issue,
      and offer your input. If you don\'t have any input, move on to another issue -
      https://github.com/backdrop/backdrop-issues/issues?q=is%3Aissue+is%3Aopen+label%3A%22needs+-+more+feedback%22',
    'Not a coder and want to contribute - have you looked through the BackdropCMS.org issue queue recently.
      There are lots of "community" issues in this queue - https://github.com/backdrop-ops/backdropcms.org/issues',
    'Drink lots of water'
  ]

  robot.hear /dragonbot (tip|tips)/i, (res) ->
    message = "\n"
    message += res.random tips
    message += "\n\n"
    message +="Type '@Dragonbot tip' for more random community tips.\n"
    res.send message
