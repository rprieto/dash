request = require 'request'

exports.config = ()->
    ['jira-server']

exports.data = (error, success) ->
    request.get {url: (uriForPriority 'Blocker'), json: true}, (err, response, blockerData) ->
        return error 'getting blockers' if response.statusCode isnt 200
        request.get {url: (uriForPriority 'Critical'), json: true}, (err, response, criticalData) ->
            return error 'getting criticals' if response.statusCode isnt 200
            blockers = blockerData.total || 0
            critical = criticalData.total || 0
            success {
                blockers: blockers 
                critical: critical 
                status: status blockers, critical
            }
            
uriForPriority = (priority) ->
                'https://jira.atlassian.com/rest/api/2/search?jql=project+%3D+GHS+AND+resolution+%3D+Unresolved+AND+priority+%3D+' + priority + '+ORDER+BY+key+DESC&mode=hide'

status = (blockers, criticals) ->
    if blockers > 0
        'fail'
    else if criticals > 0
        'warn'
    else
        'pass'