stubWidgets = require '../stubs/all-widgets'

exports.user = (req, res) ->
    res.writeHead 200, {'Content-Type', 'application/json'}
    res.write '[]'
    res.end()
    
exports.test = (req, res) ->
    res.writeHead 200, {'Content-Type', 'application/json'}
    res.write JSON.stringify stubWidgets, null, '\t'
    res.end()
