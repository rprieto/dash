sys = require 'sys'
exec = require('child_process').exec

exports.data = (error, response) ->
    exec "ping -c 3 google.com", (error, stdout, stderr) ->
        return response error if error?

        packetsRegex = /(\d+) packets transmitted, (\d+) packets received/
        matches = packetsRegex.exec stdout
        if matches[1] == matches[2]
            response {
              status: 'pass'
              icon: 'ok',
            }
        else
            response {
              status: 'fail',
              icon: 'remove'
            }
