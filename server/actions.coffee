block =
  "display": "block"
none =
  "display": "none"

toggleLogin = () ->
  if $("#user_name").html() == ''
    $("#login").css(block)
    $("#logout").css(none)
    $("#yet_logged_in").css(block)
    $("#logged_in").css(none)
    user_name = null
  else
    $("#login").css(none)
    $("#logout").css(block)
    $("#yet_logged_in").css(none)
    $("#logged_in").css(block)
    user_name = $("#user_name").html()
toggleLogin()

$("#login").click ->
  data =
    user_name: $("#user_name_field").val()
  $.ajax
    url: 'login'
    type: 'post'
    data:data
    json: true
    success: (data) ->
      $("#user_name").html(data.user_name)
      toggleLogin()
      $("#result").css block
      $("#result_area").html('')
      data.codes.forEach (code) ->
        getPrice code
    error: (err) -> console.log err

$("#logout").click ->
  data =
    user_name: $("#user_name").html()
  $.ajax
    url: 'logout'
    type: 'delete'
    data: data
    success: ->
      $("#user_name").html('')
      $("#result_area").html('')
      $("#result").css none
      toggleLogin()
    error: (err) -> console.log err

$("#code_submit").click ->
  getPrice $("#code").val()

getPrice = (code) ->
  data =
    code: code
  $.ajax
    url: 'get_data'
    type: 'get'
    data: data
    success: (data) ->
      $("#result").css block
      code = data.code
      price = data.price
      $("#result_area").append("<tr><td>#{code}</td><td>#{price}</td></tr>")

codes = $("#codes").html()
if codes != 'null'
  codes.split(",").forEach (code) ->
    getPrice code
