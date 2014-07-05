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
      toggleLogin()
    error: (err) -> console.log err
