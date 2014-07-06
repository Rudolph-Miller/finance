parseCookie = (cookies) ->
  result = {}
  cookies.split("; ").map (item) ->
   arr = item.split("=")
   result[arr[0]] = arr[1]
  result

exports.parseCookie = parseCookie
