
exports.test = (req, res) ->
    if req.params.type == 'ping'
        res.writeHead 200, {'Content-Type', 'application/json'}
        res.write '{"status":"true"}'
        res.end()
    else
        res.writeHead 404, {'Content-Type', 'text/html'}
        res.write 'Not supported'
        res.end()

exports.get = exports.test
