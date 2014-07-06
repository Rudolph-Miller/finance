users = {}

saveCode = (user_name, code) ->
  unless users[user_name]
    users[user_name] = {}
  unless users[user_name].codes
    users[user_name].codes = []
  if users[user_name].codes.indexOf(code) == -1
    users[user_name].codes.push code

getCodes = (user_name, callback) ->
  if users[user_name] && users[user_name].codes
    callback users[user_name].codes
  else
    callback null

exports.saveCode = saveCode
exports.getCodes = getCodes
