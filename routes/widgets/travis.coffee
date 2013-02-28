request = require 'request'

exports.view = 'build_status'

exports.data = (error, success) ->
    projectUri = 'http://travis-ci.org/repositories.json?search=rprieto/dash'
    request {url: projectUri, json: true}, (error, response, data) ->
        success {
            build: data[0].last_build_number
            status: if data[0].last_build_status is 0 then 'pass' else 'fail'
        }
