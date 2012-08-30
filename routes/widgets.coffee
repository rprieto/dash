stubWidgets = require '../stubs/all-widgets'

exports.get = (req, res) ->
    res.writeHead 200, {'Content-Type', 'application/json'}
    res.write JSON.stringify stubWidgets, null, '\t'
    res.end()
