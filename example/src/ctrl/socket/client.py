
import aiozmq.rpc



class ZMQSocketClient(object):

    def __init__(self, loop, server_addr):
        self.loop = loop
        self.server_addr = server_addr

    async def start(self):
        print('Startng socket client')
        client = await aiozmq.rpc.connect_rpc(connect=self.server_addr)
        print(await client.call.remote_func(1, 2))
