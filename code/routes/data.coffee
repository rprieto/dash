request = require 'request'

hudson = (callback) ->
    projectUri = 'http://ci.jenkins-ci.org/job/jenkins_pom/api/json?pretty=true'
    request projectUri, (error, response, body) ->
        buildUri = (JSON.parse body).lastBuild.url + 'api/json?pretty=true'
        request buildUri, (error, response, body) ->
            buildData = JSON.parse body
            callback {
                number: buildData.number
                result: buildData.result        
            }

exports.test = (req, res) ->
    switch req.params.type
        when 'ping'
            sys = require 'sys'
            exec = require('child_process').exec
            exec 'ping -c 3 google.com', (error, stdout, stderr) ->
                packetsRegex = /(\d+) packets transmitted, (\d+) packets received/
                matches = packetsRegex.exec stdout
                res.writeHead 200, {'Content-Type', 'application/json'}
                if matches[1] == matches[2]
                    res.write '{"status":"pass"}'
                else
                    res.write '{"status":"fail"}'
                res.end()
        when 'hudson-build-status'
            res.writeHead 200, {'Content-Type', 'application/json'}
            hudson (data) ->
                status = if data.result is 'SUCCESS' then "pass" else "fail"
                res.write '{"build":"' + data.number + '", "status":"' + status + '"}'
                res.end() 
        when 'countdown'
            res.writeHead 200, {'Content-Type', 'application/json'}
            res.write '{"days":5}'
            res.end()                
        else
            res.writeHead 404, {'Content-Type', 'text/html'}
            res.write 'Not supported'
            res.end()

exports.get = exports.test
