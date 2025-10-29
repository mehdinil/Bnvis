# 🌟 Benevis Life OS — Vision Document

## 🎯 رویا

**Benevis Life OS** یک سیستم‌عامل زندگی شخصی است که هر کاربر (دانش‌آموز، کارمند، فریلنسر، مدیر) را با یک **موتور هوشمند** هدایت می‌کند تا زندگی خود را مدیریت کند.

---

## 🎨 طراحی (UI/UX از Canva)

### رنگ‌ها
- **پایه:** گرادینت آبی نئونی → بنفش (`#5468FF` تا `#C77DFF`)
- **پس‌زمینه:** Dark: `#0B0F25` / Light: `#F8F9FF`
- **کارت‌ها:** Glassmorphic با blur و opacity

### فونت
- **فارسی:** IRANSans / Vazir
- **انگلیسی:** Inter / SF Pro

### سبک
- **Glassmorphic Cards** با سایه نرم
- **Radius:** 16-20dp
- **انیمیشن:** Fade-slide برای صفحات
- **Navigation:** Bottom Bar با 5 تب

---

## 🧩 ماژول‌های اصلی

### 📊 Dashboard (Home)
- **کارت پیشرفت روزانه**
- **اهداف فعال** با progress bar
- **Streak عادات**
- **یادداشت سریع**
- **AI Coach Insight** (پیشنهاد روزانه)

### 🎯 Goals (اهداف)
- ایجاد هدف با معیارهای قابل اندازه‌گیری (OKR)
- پیشرفت به صورت درصد یا checkbox
- Deadline و یادآوری
- تگ‌گذاری (کاری، شخصی، مالی، سلامت)

### 🔄 Habits (عادات)
- عادت‌های روزانه/هفتگی/ماهانه
- Streak counter با نمایش آتش 🔥
- یادآوری هوشمند
- نمودار پیشرفت

### 📔 Journal (ژورنال)
- یادداشت روزانه با Rich Text
- Mood Tracker (emoji)
- عکس و صدا
- AI Analysis: نکات الهام‌بخش از متن

### 🎓 Skills (مهارت‌ها)
- مهارت‌هایی که می‌خواهم یاد بگیرم
- ساعات تمرین
- منابع یادگیری
- پیشرفت با milestone

### 💰 Finance (مالی)
- بودجه ماهانه
- تراکنش‌ها (درآمد/هزینه)
- دسته‌بندی خودکار
- گزارش خلاصه

### 🤖 AI Coach
- توصیه‌های روزانه بر اساس داده کاربر
- تحلیل ژورنال و ارائه بینش
- پیشنهاد هدف بعدی
- Mock Offline در فاز اول

### ⚙️ Settings
- پروفایل (نام، شغل، اهداف کلان)
- تم (رنگ، فونت، dark/light)
- امنیت (قفل بیومتریک، رمزگذاری)
- بکاپ/ریستور (JSON)
- درباره ما و حمایت

---

## 💬 آن‌بوردینگ پویا (Smart Onboarding)

### موتور دیالوگی چندمرحله‌ای

**اسلاید ۱: خوش‌آمدگویی**
```
🌟 به بنویس خوش آمدید!
سیستم هوشمند مدیریت زندگی
```

**اسلاید ۲: نام و هدف**
```
اسم شما چیه؟
هدف اصلی شما در زندگی چیه؟
[دکمه: ادامه]
```

**اسلاید ۳: عادات**
```
۳ عادت روزانه که می‌خواهید داشته باشید؟
- مطالعه
- ورزش
- مدیتیشن
[Chip Selection]
```

**اسلاید ۴: مهارت‌ها**
```
چه مهارتی می‌خواهید یاد بگیرید؟
- برنامه‌نویسی
- زبان انگلیسی
- طراحی UI/UX
- سایر...
```

**اسلاید ۵: روتین**
```
ساعت خواب و بیداری؟
[Time Picker]
```

**اسلاید ۶: تم**
```
تم مورد علاقه؟
- Neon Blue
- Purple Dream
- Minimal Dark
- Light Mode
[Preview Cards]
```

**اسلاید ۷: نوع کاربر**
```
شما کی هستید؟
- 🎓 دانشجو
- 💼 کارمند
- 💻 فریلنسر
- 🚀 مدیر/کارآفرین
```

**نتیجه:**
- پروفایل کامل ساخته می‌شود
- Dashboard شخصی‌سازی می‌شود
- ماژول‌های مرتبط فعال می‌شوند

---

## ⚙️ معماری فنی

### Stack
- **Flutter 3.24+** (Material 3)
- **State Management:** Riverpod 3.0+
- **Local DB:** Isar 3.1+ (سریع و قدرتمند)
- **Secure Storage:** flutter_secure_storage
- **Localization:** flutter_localizations (fa + en)
- **Biometric:** local_auth
- **Export:** share_plus + file_picker

### ساختار پوشه‌ها
```
lib/
  core/
    config/
      app_config.dart          # kDemoMode, kVersion
      theme_config.dart        # Theme definitions
    models/
      user_profile.dart
    services/
      storage_service.dart
      export_service.dart
      ai_coach_service.dart
  modules/
    onboarding/
      screens/
      widgets/
      logic/
    goals/
      data/
      logic/
      screens/
    habits/
    journal/
    skills/
    finance/
    ai_coach/
    settings/
  shared/
    widgets/
      glass_card.dart
      gradient_button.dart
      progress_ring.dart
    theme/
      colors.dart
      text_styles.dart
  main.dart
```

---

## 🔐 امنیت و حریم خصوصی

### Local-First
- همه داده‌ها روی دستگاه ذخیره می‌شوند
- بدون ارسال به سرور (در فاز اول)
- رمزگذاری AES برای داده حساس

### قفل اپ
- PIN / Pattern / Biometric
- خودکار قفل شدن بعد از 5 دقیقه

### Feature Flags
- دسترسی به SMS بانکی (غیرفعال پیش‌فرض)
- Notification Listener (آینده)
- Google Drive Sync (فاز 2)

---

## 💰 مدل درآمدی

### Free Tier
- ۱۰ هدف فعال
- ۱۵ عادت
- ژورنال نامحدود
- تم‌های پایه
- AI Coach ساده

### Pro (۹۹-۱۴۹ ت/ماه یا ۹۹۰ ت/سال)
- هدف و عادت نامحدود
- تم‌های پریمیوم
- رمزگذاری کامل
- AI Coach پیشرفته
- بکاپ Google Drive
- آمار پیشرفته

### Global (جهانی)
- $2.99/ماه
- $24.99/سال
- $39 Lifetime

---

## 📈 Roadmap

### Phase 1 (MVP) — ۲-۳ هفته
- ✅ آن‌بوردینگ پویا
- ✅ Profile + Settings
- ✅ Goals CRUD
- ✅ Habits Tracker
- ✅ Journal با Mood
- ✅ Theme Engine
- ✅ Demo Mode
- ✅ Workflow بیلد (Demo + Normal APK)

### Phase 2 (Finance + AI) — ۲ هفته
- 💰 Finance Module
- 🤖 AI Coach (تحلیل ژورنال)
- 📊 Statistics Dashboard
- 🔔 Notification System

### Phase 3 (Pro + Sync) — ۳ هفته
- 🔐 Biometric Lock
- ☁️ Google Drive Sync
- 💳 In-App Purchase (Pro)
- 🏦 Banking SMS Parser (با رضایت)

### Phase 4 (Polish + Launch) — ۲ هفته
- 🎨 UI Polish
- 🧪 Testing
- 📱 App Store + Play Store
- 🌍 Marketing

---

## 🎯 Success Metrics

### UX
- ⏱️ Time to first value: < 2 دقیقه
- 🎨 Onboarding completion: > 80%
- 📱 Daily Active Users: 10K در 3 ماه

### Business
- 💰 Conversion to Pro: 5-10%
- ⭐ Rating: > 4.5
- 🔁 Retention (7 days): > 40%

---

## 🤝 رقبا و الهام

### جهانی
- **Notion** — ماژولار بودن
- **Todoist** — UI ساده
- **Reflectly** — AI Journal
- **Habitica** — Gamification
- **Stoic** — Philosophy + Journaling

### ایرانی
- **یادا** — ژورنال فارسی
- **روتینو** — عادت‌سازی
- **نیک‌روز** — برنامه‌ریزی

### مزیت رقابتی Benevis
- ✅ All-in-one (بدون نیاز به چند اپ)
- ✅ آن‌بوردینگ هوشمند
- ✅ AI Coach داخلی
- ✅ Privacy-first
- ✅ فارسی Native

---

## 🎨 AI Coach (آفلاین Mock در فاز اول)

### ویژگی‌ها
- تحلیل ژورنال و استخراج احساسات
- پیشنهاد هدف بعدی بر اساس عادات
- توصیه روزانه (Morning Insight)
- نقل قول الهام‌بخش

### مثال
```
کاربر می‌نویسد: "امروز خسته بودم ولی ورزش کردم"
AI Coach:
💪 عالی! حتی در روزهای سخت هم عادت‌هات رو حفظ کردی.
پیشنهاد: یک هدف کوچک برای فردا تعیین کن تا انرژی بیشتری داشته باشی.
```

### Implementation
- **فاز اول:** Rule-based (keyword detection)
- **فاز دوم:** TFLite model (sentiment analysis)
- **فاز سوم:** API به LLM (با رضایت کاربر)

---

## 📦 خروجی نهایی

### Flutter Project
- ✅ Clean Architecture
- ✅ مستندسازی کامل
- ✅ Type-safe + Null-safe
- ✅ RTL Support
- ✅ Localization (fa + en)
- ✅ Unit Tests برای منطق مهم

### GitHub Workflow
- ✅ Auto-build on push
- ✅ دو APK: Demo + Normal
- ✅ Artifact ready to install

### Documentation
- ✅ README.md
- ✅ SETUP.md
- ✅ CONTRIBUTING.md
- ✅ CHANGELOG.md

---

## ✨ تفاوت با نسخه قبل

| ویژگی | نسخه قبل | Benevis Life OS |
|-------|----------|-----------------|
| آن‌بوردینگ | فرم ساده | موتور پویا با سوالات هوشمند |
| ماژول‌ها | Goals + Habits | Goals + Habits + Journal + Skills + Finance |
| AI | ندارد | AI Coach داخلی |
| تم | تک تم | Theme Engine با 4+ تم |
| امنیت | پایه | Biometric + رمزگذاری |
| درآمد | رایگان | Free + Pro با IAP |

---

**تهیه‌شده در:** 2025-10-29  
**نسخه:** 1.0  
**وضعیت:** 🚧 در حال توسعه
