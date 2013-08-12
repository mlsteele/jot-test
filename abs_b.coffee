{TCPLocalNode, TCPForeignNode} = require './nettcp'

PORT = 2058

local_node = new TCPLocalNode PORT
local_node.listen()
