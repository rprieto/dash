sys = require 'sys'
exec = require('child_process').exec

exports.data = (config, callback) ->
    exec "ping -c 3 #{config.host}", (error, stdout, stderr) ->
        return callback error if error?

        packetsRegex = /(\d+) packets transmitted, (\d+) packets received/
        matches = packetsRegex.exec stdout
        if matches[1] == matches[2]
            success { value: 'pass', icon: 'ok' }
        else
            success { value: 'fail', icon: 'remove' }
