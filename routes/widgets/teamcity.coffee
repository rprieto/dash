request = require 'request'

exports.buildStatus = (error, success) ->
    buildUri = 'http://teamcity.jetbrains.com/guestAuth/app/rest/builds/buildType:bt343'
    request.get {url: buildUri, json: true}, (error, response, data) ->
        success {
            build: data.number
            status: if data.result is 'SUCCESS' then 'pass' else 'fail'
        }

exports.projectStatus = (error, success) ->
    # TODO list all the failing build types in a project
    success {
        status: 'fail'
        failedBuilds: ['1. Compile', '4. Deployment', '7. UAT']
    }
