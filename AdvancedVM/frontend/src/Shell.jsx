import { useState } from 'react'
import { sendCmd } from './api.js'

export default function Shell({ vmState }) {
  const [input, setInput] = useState('');
  const [output, setOutput] = useState(['BlackBoxOS v1.0 ready. Type "help".']);

  const exec = (cmd) => {
    output.push(`$ ${cmd}`);
    // Mock sendCmd(ws, cmd); setOutput(prev => [...prev, `VM: ${cmd} executed`]);
    if (cmd === 'ps') {
      setOutput(prev => [...prev, `Processes: ${vmState.processes.join(', ')}`]);
    } else {
      setOutput(prev => [...prev, `VM: ${cmd} (advanced stub)`]);
    }
    setInput('');
  };

  return (
    <div className="bg-black/80 p-4 rounded-xl border border-green-500/50">
      <div className="text-green-400 text-sm mb-2">VM State: Mem {vmState.memory} | Procs: {vmState.processes.length}</div>
      <div className="h-24 overflow-y-auto mb-2 text-green-400">
        {output.map((line, i) => <div key={i}>{line}</div>)}
      </div>
      <div className="flex">
        <input 
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' &amp;&amp; exec(input)}
          className="flex-1 bg-transparent border-b border-green-500 outline-none text-green-400"
          placeholder="vm> "
        />
      </div>
    </div>
  );
}

