plantTimeout = (ms, cb) -> setTimeout cb, ms
jot = require 'json-over-tcp'

PORT = 2057

server = jot.createServer 'foo'
server.on 'connection', (socket) ->
  console.log "connection established"

  socket.on 'error', ->
    console.log "socket error"

  socket.on 'data', (data) ->
    console.log "received data: #{JSON.stringify data}"

  plantTimeout 3000, ->
    console.log "pushing down..."
    socket.write push: 'down'

  socket.on 'close', ->
    console.log "disconnected"

  plantTimeout 5000, ->
    console.log "disconnecting..."
    socket.destroy()

server.listen PORT
