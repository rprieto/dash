request = require 'request'

exports.buildStatus = (jsonResponse) ->
    buildUri = 'http://teamcity.jetbrains.com/guestAuth/app/rest/builds/buildType:bt343'
    request.get {url: buildUri, json: true}, (error, response, data) ->
        jsonResponse {
            build: data.number
            status: if data.result is 'SUCCESS' then 'pass' else 'fail'
        }

exports.projectStatus = (jsonResponse) ->
    # TODO list all the failing build types in a project
    jsonResponse {
        status: 'fail'
        failedBuilds: ['1. Compile', '4. Deployment', '7. UAT']
    }
