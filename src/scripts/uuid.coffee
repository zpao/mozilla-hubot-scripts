# Generate a uuid or cid.
#
# uuid - Generate a UUID.
# cid - Generate a UUID but outputs format suitable for components (CID).

exec = require("child_process").exec
module.exports = (robot) ->
  robot.respond /(uuid|cid)/i, (msg) ->
    exec "uuidgen", (error, stdout, stderr) ->
      uuid = stdout.trim().toLowerCase()
      if msg.match[1] == "uuid"
        msg.send "#{uuid}"
        # firebot does that extra message but meh
        # msg.send "#{uuid} (/msg #{robot.name} cid for CID form)"
      else
        split = uuid.split "-"
        parts = [split[0], split[1], split[2]].map (p) -> "0x#{p}"
        parts2 = (split[3] + split[4]).match(/../g).map (p)-> "0x#{p}"

        parts.push "{#{parts2.join(", ")}}"
        msg.send "{#{parts.join(", ")}}"
