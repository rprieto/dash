exports.ping = require('./ping').render
exports.countdown = require('./countdown').countdown
exports.hudson_build_status = require('./hudson').buildStatus
exports.teamcity_build_status = require('./teamcity').buildStatus
exports.sonar_code_coverage = require('./sonar').sonarCodeCoverage
exports.jira_issues = require('./jira').jiraIssues
exports.jira_burn_up = require('./jira').burnUp
exports.twitter_hashtag = require('./twitter').hashtag
