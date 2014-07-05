server = require './server'
handler = require './handler'
router = require './routes'
controller = require './controller'
finance = require './finance'

handle =
  '/': handler.index
  '/login': handler.login
  '/logout': handler.logout
  '/get_data': finance.getData
  '/controller': controller.index

server.start(router.route, handle)
