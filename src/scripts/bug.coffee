# Get bug information from bugzilla.
#
# bug <bugnumber> - Get bug information.

Bz = require "bz"
Client = Bz.createClient({
  url: "https://api-dev.bugzilla.mozilla.org/1.0/"
})


module.exports = (robot) ->
  robot.hear /bug (\d+)/i, (msg) ->
    Client.getBug msg.match[1], (error, bug) ->

      title = "Bug #{bug.id}"
      title += " (#{bug.alias})" if bug.alias
      title += " - #{bug.summary}"

      resolution = "#{bug.status}"
      resolution += "#{bug.resolution}" if bug.resolution instanceof String

      assignee = "assigned to: #{bug.assigned_to.name}"

      # bug.url isn't set properly, so build it ourselves
      url = makeBugURL bug.id
      # url = "https://bugzilla.mozilla.org/show_bug.cgi?id=#{bug.id}"

      msg.send [title, resolution, assignee, url].join " | "

  robot.respond /changesets for bug (\d+)/i, (msg) ->
    options =
      include_fields: ["comments", "id"].join ","

    Client.getBug msg.match[1], options, (error, bug) ->
      #TODO match incomplete urls
      regex = /(http:\/\/hg\.mozilla\.org\S+\/rev\/\S+)/g
      matches = []
      bug.comments.forEach (comment, index) ->
        urls = comment.text.match regex
        if urls && urls.length
          # matches = matches.concat urls
          urls.forEach (url) ->
            matches.push "#{url} (#{makeBugURL(bug.id, index)})"
            #matches.push "#{url} (https://bugzil.la/#{bug.id}#c#{index})"
      msg.send matches.join "\n"

makeBugURL = (number, comment) ->
  url = "http//bugzil.la/#{number}"
  url += "##{comment}" if comment
  return url
