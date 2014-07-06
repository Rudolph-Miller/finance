login_user = {}

current_session = (req, callback) ->
  cookies = parseCookie req.headers.cookie
  session_token = cookies.session_token
  unless session_token
    callback null
  else
    callback session_token

login = (current_session, user_name, callback) ->
  if login_user[current_session] && login_user[current_session].user_name
    callback 'something wrong'
  else
    login_user[current_session] = {}
    login_user[current_session].user_name = user_name
    callback null, 'OK'

logout = (current_session, user_name, callback) ->
  unless login_user[current_session] && login_user[current_session].user_name
    callback 'something wrong'
  else
    delete login_user[current_session]
    callback null, 'OK'

login_p = (current_session, callback) ->
  if login_user[current_session] && login_user[current_session].user_name
    callback login_user[current_session].user_name
  else
    callback false

parseCookie = (cookies) ->
  result = {}
  cookies.split("; ").map (item) ->
   arr = item.split("=")
   result[arr[0]] = arr[1]
  result

exports.current_session = current_session
exports.login = login
exports.logout = logout
exports.login_p = login_p
