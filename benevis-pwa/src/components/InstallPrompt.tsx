import React, { useEffect, useState } from 'react';

export function InstallPrompt() {
  const [deferred, setDeferred] = useState<any>(null);
  const [canInstall, setCanInstall] = useState(false);

  useEffect(() => {
    const onBeforeInstall = (e: any) => {
      e.preventDefault();
      setDeferred(e);
      setCanInstall(true);
    };
    window.addEventListener('beforeinstallprompt', onBeforeInstall as any);
    return () => window.removeEventListener('beforeinstallprompt', onBeforeInstall as any);
  }, []);

  async function install() {
    if (!deferred) return;
    setCanInstall(false);
    const choice = await deferred.prompt();
    await choice.userChoice;
    setDeferred(null);
  }

  if (!canInstall) return null;
  return <button onClick={install} className="px-2 py-1 glass">نصب</button>;
}
