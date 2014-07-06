fs = require 'fs'
haml = require 'hamljs'
hr = require './haml_render'
session = require './session'
user = require './user'

layout = (locals, callback) ->
  hr.render '../view/layout.haml', locals, callback

index = (res, query) ->
  current_session = query.current_session
  if current_session == null
    current_session = +(new Date())
    console.log "New Session: #{current_session}"
    res.writeHead '200', 'Set-Cookie': "session_token=#{current_session}", 'Content-Type': 'text/html'
  else
    res.writeHead '200', 'Content-Type': 'text/html'
  session.login_p current_session, (user_name) ->
    locals =
      user_name: if user_name then user_name else ''
    hr.render '../view/header.haml',locals, (err, data) ->
      if err
        console.log err
      else
        header = data
        user.getCodes user_name, (codes) ->
          locals =
            codes: codes
          hr.render '../view/index.haml', locals, (err, data) ->
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
  current_session = query.current_session
  user_name = query.user_name
  session.login current_session, user_name, (err, result) ->
    if err
      res.writeHead '500', 'Content-Type': 'text/html'
      res.write 'forbidden'
      res.end()
    else
      res.writeHead '200', 'Content-Type': 'application/json'
      data =
        user_name: user_name
      user.getCodes user_name, (codes) ->
        if codes
          data.codes = codes
        res.write JSON.stringify data
        res.end()

logout = (res, query) ->
  current_session = query.current_session
  user_name = query.user_name
  session.logout current_session, user_name, (err, result) ->
    if err
      res.writeHead '500', 'Content-Type': 'text/html'
      res.write 'forbidden'
      res.end()
    else
      res.writeHead '200', 'Content-Type': 'text/plain'
      res.write 'OK'
      res.end()

exports.index = index
exports.login = login
exports.logout = logout
