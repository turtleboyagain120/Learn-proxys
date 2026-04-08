import Shell from './Shell.jsx';

export default function Desktop({ vmState }) {
  const icons = [
    { name: 'Calculator', cmd: 'exec /bin/calc', icon: '🧮' },
    { name: 'AI', cmd: 'ai hello', icon: '🤖' },
    { name: 'Settings', cmd: 'config', icon: '⚙️' },
  ];

  return (
    <>
      <div className="flex flex-col h-screen p-8 gap-4 backdrop-blur-sm">
        <div className="text-4xl font-bold text-cyan-400 animate-pulse">BlackBoxOS</div>
        <div className="grid grid-cols-4 gap-8 text-2xl">
          {icons.map((app, i) => (
            <div key={i} className="p-8 rounded-2xl bg-white/10 hover:bg-white/20 animate-holo cursor-pointer transition-all hover:scale-110"
                 onClick={() => alert(`Launching ${app.name}`)}>
              <div>{app.icon}</div>
              <div className="text-sm mt-2">{app.name}</div>
            </div>
          ))}
        </div>
        <div className="mt-auto">
          <Shell vmState={vmState} />
        </div>
      </div>
    </>
  );
}

