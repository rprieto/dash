request = require 'request'

jsonUri = (uri) ->
    uri + 'api/json?pretty=true'

exports.buildStatus = (jsonResponse) ->
    projectUri = jsonUri 'http://ci.jenkins-ci.org/job/jenkins_pom/'
    request {url: projectUri, json: true}, (error, response, data) ->
        buildUri = jsonUri data.lastBuild.url
        request {url: buildUri, json: true}, (error, response, buildData) ->
            jsonResponse {
                build: buildData.number
                status: if buildData.result is 'SUCCESS' then 'pass' else 'fail'
            }
