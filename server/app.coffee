server = require './server'
handler = require './handler'
router = require './routes'
controller = require './controller'

handle =
  '/': handler.index
  '/login': handler.login
  '/logout': handler.logout
  '/controller': controller.index

server.start(router.route, handle)
