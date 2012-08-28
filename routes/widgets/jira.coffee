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

# Points per percentage of the iteration
fakeData = [
    {x:0,  y:0}
    {x:10, y:3}
    {x:20, y:9}
    {x:30, y:11}
    {x:40, y:14}
    {x:50, y:14}
    {x:60, y:21}
    {x:60, y:0}
    {x:100, y:0}
]

exports.burnUp = (jsonResponse) ->
    id = Math.floor Math.random() * 100000
    jsonResponse {
        chartId: 'id' + id,
        totalPoints: 21,
        pointsData: fakeData
    }
