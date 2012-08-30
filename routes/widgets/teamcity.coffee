request = require 'request'

exports.data = (error, success) ->
    buildUri = 'http://teamcity.jetbrains.com/guestAuth/app/rest/builds/buildType:bt343'
    request.get {url: buildUri, json: true}, (error, response, data) ->
        success {
            build: data.number
            status: if data.result is 'SUCCESS' then 'pass' else 'fail'
        }
