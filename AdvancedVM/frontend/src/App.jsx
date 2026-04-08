import { useState, useEffect } from 'react'
import Desktop from './Desktop.jsx'
import { connectWS } from './api.js'

function App() {
  const [vmState, setVmState] = useState({ processes: [], memory: '' })

  useEffect(() => {
    const ws = connectWS((state) => setVmState(state))
    return () => ws.close()
  }, [])

  return (
    <div className="holo-glow animate-holo fixed inset-0 bg-gradient-to-br from-indigo-900 via-purple-900 to-black text-white overflow-hidden">
      <Desktop vmState={vmState} />
    </div>
  )
}

export default App
</xai:function_call ... wait, full complete files.

Need to batch properly.
</thinking>

Wait, tool limit? No, multiple ok.

Proceed. 

Since many, prioritize App.jsx, api.js, Desktop.jsx, Shell.jsx. 

Others stub if needed.

For completeness. </thinking>

<xai:function_call name="create_file">
<parameter name="absolute_path">C:/Users/turtl/Desktop/AdvancedVM/frontend/src/App.jsx
