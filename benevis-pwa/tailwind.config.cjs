/**** Tailwind config for Benevis PWA ****/
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ['class', '[data-mode="dark"]'],
  content: [
    './index.html',
    './src/**/*.{ts,tsx}'
  ],
  theme: {
    extend: {
      colors: {
        bg: 'var(--bg)',
        card: 'var(--card)',
        text: 'var(--text)',
        accent: 'var(--accent)'
      },
      boxShadow: {
        glass: '0 10px 30px rgba(0,0,0,0.25)'
      },
      backdropBlur: {
        xs: '2px'
      }
    }
  },
  plugins: [
    function ({ addVariant }) {
      addVariant('rtl', '&:dir(rtl)');
      addVariant('ltr', '&:dir(ltr)');
    }
  ]
}
