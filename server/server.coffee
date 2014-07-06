http = require 'http'
socketIO = require 'socket.io'
url = require 'url'
haml = require 'hamljs'
qs =  require 'querystring'
events = require 'events'
session = require './session'

port = 8888

start = (route, handle) ->
  onRequest = (req, res) ->
    res.setHeader 'Access-Control-Allow-Origin', '*'
    url_parts = url.parse(req.url)
    path = url_parts.pathname
    if req.method == 'POST' || req.method == 'DELETE' || req.method == 'PUT'
      body = ''
      req.on 'data', (data) -> body += data
      req.on 'end', ->
        query = qs.parse body
        session.current_session req, (current_session) ->
          query.current_session = current_session
          route(handle, path, res, query)
    else
      query = qs.parse url_parts.query
      session.current_session req, (current_session) ->
        query.current_session = current_session
        route(handle, path, res, query)

  server = http.createServer(onRequest)
  server.listen port

exports.start = start
