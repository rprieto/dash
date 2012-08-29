request = require 'request'
widgets = require './widgets/index'

error = (res) ->
    (err) ->
        res.writeHead 503, {'Content-Type', 'application/json'}
        res.write JSON.stringify {'error': err}
        res.end()

success = (res) ->
    (json) ->
        res.writeHead 200, {'Content-Type', 'application/json'}
        res.write JSON.stringify json
        res.end()

notSupported = (res) ->    
    res.writeHead 404, {'Content-Type', 'text/html'}
    res.write 'Not supported'
    res.end()

exports.test = (req, res) ->
    widgetName = req.params.type.replace /\-/g, '_'
    if widgetName of widgets
        widgets[widgetName] error(res), success(res)
    else
        notSupported(res)

exports.get = exports.test
