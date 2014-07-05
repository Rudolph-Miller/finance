http = require 'http'
socketIO = require 'socket.io'
url = require 'url'
haml = require 'hamljs'
qs =  require 'querystring'
events = require 'events'

port = 8888

start = (route, handle) ->
  em = new events.EventEmitter
  onRequest = (req, res) ->
    res.setHeader 'Access-Control-Allow-Origin', '*'
    url_parts = url.parse(req.url)
    path = url_parts.pathname
    if req.method == 'POST' || req.method == 'DELETE' || req.method == 'PUT'
      body = ''
      req.on 'data', (data) -> body += data
      req.on 'end', ->
        query = qs.parse body
        route(handle, path, res, query, em)
    else
      query = url_parts.query
      route(handle, path, res, query)

  server = http.createServer(onRequest)
  server.listen port

exports.start = start
