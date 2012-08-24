widgets = require '../widgets'

exports.index = (req, res) ->
    res.render 'index', {
        title: 'Express'
        widgets: widgets.map (w) -> w.type
    }
