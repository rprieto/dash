request = require 'request'

uriForPriority = (priority) ->
    'https://jira.atlassian.com/rest/api/2/search?jql=project+%3D+GHS+AND+resolution+%3D+Unresolved+AND+priority+%3D+' + priority + '+ORDER+BY+key+DESC&mode=hide'

status = (blockers, criticals) ->
    if blockers > 0
        'fail'
    else if criticals > 0
        'warn'
    else
        'pass'

exports.jiraIssues = (jsonResponse) ->
    request.get {url: (uriForPriority 'Blocker'), json: true}, (error, response, blockerData) ->
        request.get {url: (uriForPriority 'Critical'), json: true}, (error, response, criticalData) ->
            blockers = blockerData.total || 0
            critical = criticalData.total || 0
            jsonResponse {
                blockers: blockers 
                critical: critical 
                status: status blockers, critical
            }

exports.burnUp = (jsonResponse) ->
    id = Math.floor Math.random() * 100000
    jsonResponse { chartId: 'id' + id }
