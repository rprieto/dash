widgets = require '../widgets'

exports.show = (req, res) ->
    res.render 'index', {
        title: 'Express'
        widgets: widgets.map (w) -> w.type
    }
