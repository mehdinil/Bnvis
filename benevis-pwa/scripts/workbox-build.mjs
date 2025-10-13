import { generateSW } from 'workbox-build';

const swDest = 'docs/sw.js';
const { count, size, warnings } = await generateSW({
  globDirectory: 'docs',
  globPatterns: ['**/*.{js,css,html,png,svg,webp,woff2}'],
  swDest,
  clientsClaim: true,
  skipWaiting: true,
  offlineGoogleAnalytics: true,
  runtimeCaching: [
    {
      urlPattern: ({ request }) => ['document', 'style', 'script'].includes(request.destination),
      handler: 'StaleWhileRevalidate',
      options: { cacheName: 'app-shell' }
    },
    {
      urlPattern: /\/icons\/|\/fonts\//,
      handler: 'CacheFirst',
      options: { cacheName: 'assets', expiration: { maxEntries: 100, maxAgeSeconds: 60 * 60 * 24 * 30 } }
    },
    {
      urlPattern: /\/api\//,
      handler: 'NetworkFirst',
      options: { cacheName: 'api', networkTimeoutSeconds: 3 }
    }
  ]
});

if (warnings.length) {
  console.warn('Workbox warnings:', warnings);
}
console.log(`Generated ${swDest}, which will precache ${count} files, totaling ${size} bytes.`);
