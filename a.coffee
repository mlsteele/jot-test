plantTimeout = (ms, cb) -> setTimeout cb, ms
jot = require 'json-over-tcp'

PORT = 2057

closed = no

server = jot.createServer PORT
# server.on 'listening'
server.on 'connection', (socket) ->
  socket.on 'data', (data) ->
    console.log data

  socket.write gotcha: yes

  plantTimeout 500, ->
    socket.destroy()
    unless closed
      console.log "closing server"
      server.close()
      closed = yes

server.listen PORT
