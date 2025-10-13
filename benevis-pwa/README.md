# Benevis PWA - سیستم عامل زندگی

PWA مدرن با Vite + React + TypeScript + Tailwind + Workbox

## ویژگی‌ها

- 🌐 زبان پیش‌فرض: فارسی (RTL) با سوئیچر fa/en
- 🎨 تم‌های متنوع: تیره/روشن + 3 برند (بنفش-آبی، سبز-فیروزه‌ای، نئومورفیک)
- 📱 نصب‌پذیر (A2HS) با App Shell سریع
- 🔌 آفلاین کامل با Workbox
- 💾 IndexedDB + localStorage fallback
- ⚡ بدون وابستگی سنگین

## نصب و اجرا

```bash
# نصب وابستگی‌ها
npm install

# توسعه
npm run dev

# بیلد برای production
npm run build

# پیش‌نمایش بیلد
npm run preview
```

## دیپلوی

خروجی `dist/` را روی هر هاست استاتیک (Netlify, Vercel, Firebase Hosting) دیپلوی کنید.

### Netlify
```bash
netlify deploy --dir=dist --prod
```

### Vercel
```bash
vercel --prod
```

## ساختار

```
benevis-pwa/
├── public/          # آیکون‌ها، manifest، favicon
├── src/
│   ├── components/  # کامپوننت‌های مشترک
│   ├── features/    # صفحات اصلی
│   ├── data/        # IndexedDB + storage
│   ├── pwa/         # Service Worker
│   └── styles/      # Tailwind + themes
└── scripts/         # Workbox build
```

## جایگزینی آیکون‌ها

1. از ابزار [PWABuilder Image Generator](https://www.pwabuilder.com/imageGenerator) استفاده کنید
2. آیکون‌های تولیدشده را در `public/icons/` قرار دهید
3. نام فایل‌ها را طبق `manifest.webmanifest` تنظیم کنید

## License

MIT
