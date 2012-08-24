
exports.get = (req, res) ->
    res.setHeader 'Content-Type', 'text/html'
    if req.param('type') == 'ping'
        res.write 'ping'
        res.end
    else
        res.write 'not supported'
        res.end
    console.log 'done'