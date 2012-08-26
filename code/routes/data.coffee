
exports.test = ->
    if req.params.type == 'ping'
        res.writeHead 200, {'Content-Type', 'application/json'}
        res.write '{"ping":"true"}'
        res.end()
    else
        res.writeHead 404, {'Content-Type', 'text/html'}
        res.write 'Not supported'
        res.end()

exports.get = exports.test
