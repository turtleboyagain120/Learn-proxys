const { useState, useEffect } = React;

const styles = {
  '*': {
    margin: 0,
    padding: 0,
    boxSizing: 'border-box'
  },
  body: {
    fontFamily: "'Arial', sans-serif",
    background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    minHeight: '100vh',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    color: 'white',
    overflow: 'hidden'
  },
  container: {
    textAlign: 'center',
    maxWidth: '600px',
    padding: '2rem',
    opacity: 1,
    transform: 'translateY(0)'
  },
  errorCode: {
    fontSize: '10rem',
    fontWeight: 'bold',
    marginBottom: '1rem',
    textShadow: '0 0 20px rgba(255,255,255,0.5)',
    transform: 'scale(1)',
    display: 'inline-block'
  },
  message: {
    fontSize: '2.5rem',
    marginBottom: '1rem',
    opacity: 0.9
  },
  description: {
    fontSize: '1.2rem',
    marginBottom: '2rem',
    opacity: 0.8,
    lineHeight: 1.6
  },
  astronaut: {
    fontSize: '8rem',
    margin: '2rem 0',
    transform: 'translateY(0px)',
    display: 'inline-block'
  },
  homeLink: {
    display: 'inline-block',
    padding: '1rem 2rem',
    background: 'rgba(255,255,255,0.2)',
    color: 'white',
    textDecoration: 'none',
    borderRadius: '50px',
    fontSize: '1.1rem',
    backdropFilter: 'blur(10px)',
    border: '1px solid rgba(255,255,255,0.3)',
    cursor: 'pointer'
  }
};

function App() {
  const [pulseScale, setPulseScale] = useState(1);
  const [floatY, setFloatY] = useState(0);
  const [fadeProgress, setFadeProgress] = useState(0);

  useEffect(() => {
    // Fade in
    const fadeTimer = setTimeout(() => setFadeProgress(1), 100);
    return () => clearTimeout(fadeTimer);
  }, []);

  useEffect(() => {
    // Pulse animation
    const pulseInterval = setInterval(() => {
      setPulseScale(1.05);
      setTimeout(() => setPulseScale(1), 1000);
    }, 2000);
    return () => clearInterval(pulseInterval);
  }, []);

  useEffect(() => {
    // Float animation
    const floatInterval = setInterval(() => {
      setFloatY(-20);
      setTimeout(() => setFloatY(0), 1500);
    }, 3000);
    return () => clearInterval(floatInterval);
  }, []);

  const containerStyle = {
    ...styles.container,
    opacity: fadeProgress,
    transform: `translateY(${30 * (1 - fadeProgress)}px)`
  };

  const errorCodeStyle = {
    ...styles.errorCode,
    transform: `scale(${pulseScale})`
  };

  const astronautStyle = {
    ...styles.astronaut,
    transform: `translateY(${floatY}px)`
  };

  return React.createElement('div', {
    style: styles.body
  }, 
    React.createElement('div', {
      className: 'container',
      style: containerStyle
    },
      React.createElement('div', {
        className: 'error-code',
        style: errorCodeStyle
      }, '404'),
      React.createElement('h1', {
        className: 'message',
        style: styles.message
      }, 'Cannot Find Page'),
      React.createElement('div', {
        className: 'astronaut',
        style: astronautStyle
      }, '🚀'),
      React.createElement('p', {
        className: 'description',
        style: styles.description
      }, "Oops! The page you're looking for has blasted off into outer space. Don't worry, we'll help you navigate back home."),
      React.createElement('a', {
        className: 'home-link',
        style: styles.homeLink,
        href: '/',
        onClick: (e) => e.preventDefault()
      }, 'Return to Homepage')
    )
  );
}

// Note: For full React, use CDN or bundler. This uses React via unpkg for simplicity.
const script = document.createElement('script');
script.src = 'https://unpkg.com/react@18/umd/react.development.js';
script.onload = () => {
  const script2 = document.createElement('script');
  script2.src = 'https://unpkg.com/react-dom@18/umd/react-dom.development.js';
  script2.onload = () => {
    const root = ReactDOM.createRoot(document.getElementById('root'));
    root.render(React.createElement(App));
    // Global styles
    const style = document.createElement('style');
    style.textContent = Object.entries(styles).map(([sel, s]) => {
      const rules = Object.entries(s).map(([p, v]) => \`\${camelToKebab(p)}: \${v}\`).join(';');
      return \`\${sel} {\${rules};\}\`;
    }).join('\\n');
    document.head.appendChild(style);

    function camelToKebab(str) {
      return str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
    }
  };
  document.head.appendChild(script2);
};
document.head.appendChild(script);
