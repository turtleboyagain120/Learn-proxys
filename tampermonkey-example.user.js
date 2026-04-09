// ==UserScript==
// @name         BLACKBOXAI Demo - Infinite Scroll Stopper + Dark Mode Toggle
// @namespace    http://blackboxai.com/
// @version      1.0
// @description  Stops infinite scroll on any site (e.g. Twitter/Reddit), adds dark mode toggle. JS example for Tampermonkey.
// @author       BLACKBOXAI
// @match        https://*/*
// @grant        GM_setValue
// @grant        GM_getValue
// @grant        GM_addStyle
// @grant        GM_notification
// @run-at       document-idle
// ==/UserScript==

(function() {
    'Use strict';

    // 1. DARK MODE TOGGLE (uses GM storage for persistence)
    let isDark = GM_getValue('darkMode', false);
    const toggleBtn = document.createElement('button');
    toggleBtn.innerText = isDark ? '☀️ Light' : '🌙 Dark';
    toggleBtn.style.position = 'fixed'; toggleBtn.style.top = '10px'; toggleBtn.style.right = '10px';
    toggleBtn.style.zIndex = '99999'; toggleBtn.style.padding = '10px'; toggleBtn.style.border = 'none';
    toggleBtn.style.background = '#333'; toggleBtn.style.color = '#fff'; toggleBtn.style.cursor = 'pointer';
    toggleBtn.style.borderRadius = '5px';
    document.body.appendChild(toggleBtn);

    function setDarkMode(dark) {
        isDark = dark;
        GM_setValue('darkMode', dark);
        if (dark) {
            GM_addStyle(`
                * { background: #121212 !important; color: #e0e0e0 !important; }
                a { color: #1da1f2 !important; }
            `);
            toggleBtn.innerText = '☀️ Light';
            GM_notification({ title: 'Dark Mode ON', text: 'Site darkened!' });
        } else {
            GM_addStyle(`* { background: white !important; color: black !important; }`);
            toggleBtn.innerText = '🌙 Dark';
            GM_notification({ title: 'Light Mode ON', text: 'Site lightened!' });
        }
    }
    toggleBtn.onclick = () => setDarkMode(!isDark);
    setDarkMode(isDark);  // Apply saved state

    // 2. STOP INFINITE SCROLL (observe & prevent auto-load)
    let scrollCount = 0;
    const maxScrolls = 3;  // Load only first 3 "pages"
    window.addEventListener('scroll', () => {
        if (++scrollCount > maxScrolls * 10) {  // Throttle
            window.scrollTo(0, 0);
            GM_notification({ title: 'Infinite Scroll Stopped', text: 'Back to top!' });
            scrollCount = 0;
        }
    });

    // 3. ADVANCED: Fetch external data & inject (cross-origin safe)
    GM_xmlhttpRequest({
        method: 'GET',
        url: 'https://api.github.com/users/blackboxai',
        onload: response => {
            const data = JSON.parse(response.responseText);
            const badge = document.createElement('div');
            badge.innerHTML = `✨ Powered by ${data.login} (${data.public_repos} repos)`;
            badge.style.position = 'fixed'; badge.style.bottom = '10px'; badge.style.left = '10px';
            badge.style.background = '#000'; badge.style.color = '#fff'; badge.style.padding = '10px';
            badge.style.borderRadius = '5px'; badge.style.fontFamily = 'Arial';
            document.body.appendChild(badge);
        }
    });

    console.log('Tampermonkey JS example loaded! Check button & scroll.');
})();

