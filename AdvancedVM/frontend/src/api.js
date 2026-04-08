export function connectWS(onUpdate) {
  const ws = new ReconnectingWebSocket('ws://localhost:8080/ws');
  
  ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    onUpdate({ processes: data.processes || [], memory: data.memory });
  };

  ws.onopen = () => {
    console.log('WS connected to VM');
    ws.send(JSON.stringify({ cmd: 'ps' }));
  };

  ws.onerror = (err) => console.error('WS error', err);

  return ws;
}

export async function sendCmd(ws, cmd) {
  ws.send(JSON.stringify({ cmd, pid: null }));
}

