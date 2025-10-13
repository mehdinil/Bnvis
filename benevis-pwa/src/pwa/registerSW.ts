if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    const isLocalhost = ['localhost', '127.0.0.1'].includes(location.hostname);
    if (import.meta.env.DEV && isLocalhost) return; // avoid in dev localhost
    navigator.serviceWorker.register(`${import.meta.env.BASE_URL}sw.js`).catch(console.error);
  });
}
