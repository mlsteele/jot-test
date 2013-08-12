jot = require 'json-over-tcp'

PORT = 2057

socket = jot.connect PORT, ->
  socket.write hey: 'yah'

  socket.on 'data', (data) ->
    console.log data

  socket.write 'bye'
