request = require 'request'
widgets = require './widgets/index'


exports.test = (req, res) ->
    widgetName = req.params.type.replace /\-/g, '_'
    if widgetName of widgets
        res.writeHead 200, {'Content-Type', 'application/json'}
        widgets[widgetName] (json) ->
            res.write JSON.stringify json
            res.end()
    else
        res.writeHead 404, {'Content-Type', 'text/html'}
        res.write 'Not supported'
        res.end()

exports.get = exports.test
