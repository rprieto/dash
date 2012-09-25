request = require 'request'
fs = require 'fs'

widgets = {}

files = fs.readdirSync('routes/widgets')
for file in files
    if file.match(/\.coffee$/) != null
        widget = require "./widgets/#{file}"
        widgetName = file.replace /\.coffee$/, ''
        widgets[widgetName] = widget

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
    if widgetName of widgets
        widgets[req.params.type].data error(res), success(res)
    else
        notSupported(res)

exports.get = exports.test
