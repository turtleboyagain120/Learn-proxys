import asyncio
import websockets
import json

async def ai_assist(cmd: str) -> str:
    """Mock AI for BlackBoxOS shell"""
    uri = "ws://rust-vm:8080/ws"
    async with websockets.connect(uri) as ws:
        msg = json.dumps({"cmd": f"ai {cmd}"})
        await ws.send(msg)
        resp = await ws.recv()
        return json.loads(resp).get("result", "AI: Understood.")

if __name__ == "__main__":
    asyncio.run(ai_assist("hello VM"))

