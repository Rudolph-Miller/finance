haml = require 'hamljs'
fs = require 'fs'

render = (filename, locals, callback) ->
  console.log "rendering #{filename}"
  addLine = "%script{src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js'}" + "%script{src: 'controller'}"
  fs.readFile filename, 'utf-8', (err, data) ->
    if err
      console.log err
      callback err
    else
      unless filename == '../view/header.haml' || filename == '../view/layout.haml'
        data = data + addLine
      callback null, (haml.render data, locals: locals)

exports.render = render
