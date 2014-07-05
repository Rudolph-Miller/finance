fs = require 'fs'
haml = require 'hamljs'
hr = require './haml_render'

layout = (locals, callback) ->
  hr.render '../view/layout.haml', locals, callback

index = (res, query) ->
  res.writeHead '200', 'Content-Type': 'text/html'
  locals =
    user_name: 'undefined'
  hr.render '../view/header.haml',locals, (err, data) ->
    if err
      console.log err
    else
      header = data
      hr.render '../view/index.haml', null, (err, data) ->
        if err
          console.log err
        else
          body = data
          locals =
            header: header
            body: body
          layout locals, (err, data) ->
            if err
              console.log err
            else
              res.write data
              res.end()

login = (res, query) ->
  res.writeHead '200', 'Content-Type': 'application/json'
  user_name = query.user_name
  data =
    user_name: user_name
  res.write JSON.stringify data
  res.end()

logout = (res, query) ->
  res.writeHead '200', 'Content-Type': 'text/plain'
  res.write 'OK'
  res.end()

exports.index = index
exports.login = login
exports.logout = logout
