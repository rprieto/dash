connect = require 'connect'

PORT = 3002;

console.log 'Listening on port ' + PORT
	
connect()
	.use(connect.logger('dev'))
	.use(connect.static('public'))
	.listen PORT
