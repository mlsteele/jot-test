plantTimeout = (ms, cb) -> setTimeout cb, ms
{TCPLocalNode, TCPForeignNode} = require './nettcp'

PORT = 2057

local_node = new TCPLocalNode PORT
local_node.listen()

foreign_node = new TCPForeignNode 'localhost',

plantTimeout 1000, ->
  local_node._send
