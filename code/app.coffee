
# Module dependencies
express = require 'express'
http = require 'http'
path = require 'path'

# Routes
home = require './routes/home'
widgets = require './routes/widgets'
data = require './routes/data'

app = express()

app.configure () ->
    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'ejs'
    app.use express.favicon './public/favicon.ico'
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('your secret here')
    app.use express.session()
    app.use app.router
    app.use require('connect-assets')()
    app.use express.static path.join(__dirname, 'public')

app.configure 'development', () ->
    app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
    app.use express.errorHandler()

app.get '/', home.dashboard
app.get '/test', home.test
app.get '/widgets/user', widgets.user
app.get '/widgets/test', widgets.test
app.get '/widget/:type/data', data.get
app.get '/widget/:type/test', data.test

http.createServer(app).listen app.get('port'), () ->
    console.log 'Express server listening on port ' + app.get('port')
