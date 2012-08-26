
exports.test = (req, res) ->
    switch req.params.type
        when 'ping'
            res.writeHead 200, {'Content-Type', 'application/json'}
            res.write '{"status":"ok"}'
            res.end()
        when 'hudson-build-status'
            res.writeHead 200, {'Content-Type', 'application/json'}
            res.write '{"status":"passed"}'
            res.end()        
        else
            res.writeHead 404, {'Content-Type', 'text/html'}
            res.write 'Not supported'
            res.end()

exports.get = exports.test
