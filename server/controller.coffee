fs = require 'fs'
coffee = require 'coffee-script'

index = (res) ->
  fs.readFile 'actions.coffee', 'utf-8', (err, data) ->
    if err
      console.log err
    else
      res.writeHead 200, "Content-Type": "text/javascript"
      res.end coffee.compile data

exports.index = index
