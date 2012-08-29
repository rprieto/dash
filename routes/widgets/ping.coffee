sys = require 'sys'
exec = require('child_process').exec

exports.ping = (error, success) ->
    exec 'ping -c 3 google.com', (error, stdout, stderr) ->
        packetsRegex = /(\d+) packets transmitted, (\d+) packets received/
        matches = packetsRegex.exec stdout
        if matches[1] == matches[2]
            success { status: 'pass', icon: 'ok' }
        else
            success { status: 'fail', icon: 'remove' }
