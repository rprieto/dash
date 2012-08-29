request = require 'request'

exports.sonarCodeCoverage = (error, success) ->
    uri = 'https://sonar.springsource.org/api/resources?resource=org.springframework.integration:spring-integration&metrics=coverage'
    request.get {url: uri, json: true}, (error, response, data) ->
        value = Math.floor data[0].msr[0].val
        id = Math.floor Math.random() * 100000
        success {
            value: value
            chartId: 'id' + id
        }
