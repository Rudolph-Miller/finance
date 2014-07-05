request = require 'request'
jsdom = require 'jsdom'
jquery = require 'jquery'

getData = (res, query) ->
  code = query.code
  uri = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{query.code}"
  console.log uri
  options =
    uri: uri
  request.get options, (err, response, body) ->
    if err
      console.log err
      res.writeHead '500', 'Content-Type': 'text/plain'
      res.write 'error'
      res.end()
    else
      res.writeHead '200', 'Content-Type': 'application/json'
      $ = jquery(jsdom.jsdom(body).createWindow())
      price = +($(".stoksPrice").text().replace /,/g, '')
      data =
        code: query.code
        price: price
      res.write JSON.stringify data
      res.end()

exports.getData = getData
