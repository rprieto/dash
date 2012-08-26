stubWidgets = require '../stubs/all-widgets'

exports.all = (req, res) ->
    res.writeHead 200, {'Content-Type', 'application/json'}
    res.write JSON.stringify stubWidgets, null, '\t'
    res.end()
    
exports.test = (req, res) ->
    if req.params.type == 'ping'
        res.writeHead 200, {'Content-Type', 'application/json'}
        res.write '{"ping":"true"}'
        res.end()
    else
        res.writeHead 404, {'Content-Type', 'text/html'}
        res.write 'Not supported'
        res.end()

exports.data = exports.test
