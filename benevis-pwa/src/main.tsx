import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import '@/styles/tailwind.css';
import '@/styles/themes.css';
import '@/pwa/registerSW';

const root = createRoot(document.getElementById('root')!);
root.render(<App />);
