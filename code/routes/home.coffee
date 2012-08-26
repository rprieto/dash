
exports.dashboard = (req, res) ->
    res.writeHead '302', {location: '/test'}
    res.end()
    # res.render 'home', {
    #     uri: '/widgets/user'
    # }

exports.test = (req, res) ->
    res.render 'home', {
        uri: '/widgets/test'
    }
