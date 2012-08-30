
exports.dashboard = (req, res) ->
    res.render 'home', {
        uri: '/widgets'
    }
