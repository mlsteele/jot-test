jot = require 'json-over-tcp'

class TCPLocalNode
  constructor: (@port, @hostname) ->
    unless @port?
      throw new Error "Missing port argument for constructor."
    unless typeof @port is 'number'
      throw new Error "Bad port #{@port}"

    # mapping from `TCPForeignNode.node_id`s to jot `Socket`s
    @_sockets = {}

    @server = jot.createServer ->

    @server.on 'connection', (socket) ->
      console.log "connection established"

      socket.on 'error', ->
        console.log "socket error"

      socket.on 'data', (data) ->
        console.log "received data: #{JSON.stringify data}"

      socket.on 'close', ->
        console.log "disconnected"

  listen: ->
    @server.listen @port, @hostname

  _send: (foreign_node, data) ->
    unless foreign_node instanceof TCPForeignNode
      throw new Error "foreign_node is not a TCPForeignNode."

    unless @_sockets[foreign_node.node_id]?
      throw new Error "socket not connected"

    @_sockets[foreign_node.node_id].write data


class TCPForeignNode
  constructor: (@hostname, @port) ->
    @node_id = "node:tcp://#{@hostname}:#{@port}"


module.exports =
  TCPLocalNode: TCPLocalNode
  TCPForeignNode: TCPForeignNode
