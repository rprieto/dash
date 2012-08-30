request = require 'request'

searchUri = (keyword) ->
    'http://search.twitter.com/search.json?q=' + keyword + '&rpp=1&include_entities=false&result_type=recent'


exports.data = (error, success) ->
    request {url: (searchUri 'build'), json: true}, (error, response, data) ->
        success { tweet: data.results[0].text }
