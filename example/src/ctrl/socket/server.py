
import aiozmq.rpc


class ServerHandler(aiozmq.rpc.AttrHandler):

    def __init__(self):
        self.connected = False

    @aiozmq.rpc.method
    def remote_func(self, a: int, b: int) -> int:
        self.connected = True
        print("HANDLER", a, b)
        return a + b


class ZMQSocketServer(object):

    def __init__(self, loop, server_addr):
        self.loop = loop
        self.server_addr = server_addr

    async def start(self):
        print("Starting socket server")
        handler = ServerHandler()
        server = await aiozmq.rpc.serve_rpc(
            handler,
            bind=self.server_addr)
        print("SERVE", self.server_addr)
