plantTimeout = (ms, cb) -> setTimeout cb, ms
jot = require 'json-over-tcp'

PORT = 2057

do connect = ->
  socket = jot.connect PORT, ->
    console.log "connection established"

    socket.on 'data', (data) ->
      console.log "received data: #{JSON.stringify data}"

    plantTimeout 1000, ->
      console.log "pushing up..."
      socket.write push: 'up'

    socket.on 'close', ->
      console.log "disconnected"
      plantTimeout 1000, ->
        console.log "reconnecting..."
        connect()
