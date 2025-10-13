# 🎯 از اینجا شروع کنید!

خوش آمدید به پروژه **Tablo (GoalPad)**! 🎉

---

## 📚 راهنماهای موجود

این پروژه 4 راهنمای جامع دارد. **بسته به سطح تجربه خود، یکی را انتخاب کنید:**

---

### 1️⃣ **تازه کار هستید؟** → `SETUP_GUIDE.md`

📖 **راهنمای کامل Setup (100+ خط)**

این راهنما شامل:
- نصب گام‌به‌گام Flutter SDK
- تنظیم PATH در Windows/Mac/Linux
- توضیح تمام دستورات
- رفع خطاهای رایج با مثال
- تنظیمات Android و iOS با جزئیات
- Debug و logging

**برای چه کسی؟**
- اولین بار Flutter نصب می‌کنید
- با terminal آشنایی کم دارید
- می‌خواهید همه چیز را بفهمید

🔗 **باز کردن:** [SETUP_GUIDE.md](./SETUP_GUIDE.md)

---

### 2️⃣ **Flutter نصب کردید؟** → `QUICKSTART.md`

⚡ **راهنمای سریع (فقط دستورات)**

فقط دستورات ضروری، بدون توضیح زیاد:
```powershell
cd goalpad
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

**برای چه کسی؟**
- Flutter SDK از قبل نصب است
- می‌خواهید سریع اجرا کنید
- با Flutter آشنا هستید

🔗 **باز کردن:** [QUICKSTART.md](./QUICKSTART.md)

---

### 3️⃣ **فقط یک نگاه سریع؟** → `CHEATSHEET.md`

📋 **چیت شیت (1 صفحه)**

تمام دستورات مهم در یک صفحه:
- دستورات اصلی
- رفع خطاهای رایج
- Hot keys
- Debugging

**برای چه کسی؟**
- می‌خواهید reference سریع داشته باشید
- دستورات را فراموش می‌کنید
- نیاز به یادآوری دارید

🔗 **باز کردن:** [CHEATSHEET.md](./CHEATSHEET.md)

---

### 4️⃣ **می‌خواهید feature جدید را بفهمید؟** → `FEATURE_EXPORT_IMPORT.md`

📦 **راهنمای Feature Export/Import**

توضیح کامل feature جدید:
- معماری پیاده‌سازی
- JSON format
- API documentation
- نکات امنیتی
- Performance

**برای چه کسی؟**
- می‌خواهید کد را بفهمید
- قصد توسعه feature جدید دارید
- برای مشارکت در پروژه

🔗 **باز کردن:** [FEATURE_EXPORT_IMPORT.md](./FEATURE_EXPORT_IMPORT.md)

---

### 5️⃣ **می‌خواهید تست کنید؟** → `INTEGRATION_GUIDE.md`

🧪 **راهنمای تست و Integration**

سناریوهای تست کامل:
- تست Export/Import
- بررسی فایل JSON
- Debugging
- عیب‌یابی

**برای چه کسی؟**
- اپ اجرا شده، می‌خواهید تست کنید
- مشکل دارید و نمی‌دانید از کجا شروع کنید
- می‌خواهید QA انجام دهید

🔗 **باز کردن:** [INTEGRATION_GUIDE.md](./INTEGRATION_GUIDE.md)

---

## 🚀 پیشنهاد ما

### اگر **Flutter نصب نکرده‌اید:**

```
1. SETUP_GUIDE.md را باز کنید
2. بخش 1 و 2 را دنبال کنید (نصب Flutter + PATH)
3. بعد به QUICKSTART.md بروید
4. دستورات را به ترتیب اجرا کنید
```

### اگر **Flutter نصب کرده‌اید:**

```
1. QUICKSTART.md را باز کنید
2. دستورات را کپی-پیست کنید
3. اگر خطا گرفتید → SETUP_GUIDE.md بخش 10
4. بعد از اجرا → INTEGRATION_GUIDE.md برای تست
```

---

## 🎯 دستورات کلیدی (خلاصه خلاصه!)

```powershell
# 1. رفتن به پوشه پروژه
cd C:\Users\ASUS\Desktop\Tablo\goalpad

# 2. نصب dependencies
flutter pub get

# 3. ساخت Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# 4. اجرا
flutter run
```

---

## ❓ سوالات متداول

### ❓ Flutter نصب نیست، چکار کنم?

👉 به `SETUP_GUIDE.md` بروید، بخش 1 و 2

### ❓ خطای `*.g.dart not found` می‌گیرم

👉 اجرا کنید:
```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

### ❓ Export/Import کار نمی‌کند

👉 به `INTEGRATION_GUIDE.md` بروید، بخش "عیب‌یابی"

### ❓ می‌خواهم کد را بفهمم

👉 به `FEATURE_EXPORT_IMPORT.md` بروید

### ❓ می‌خواهم feature جدید اضافه کنم

👉 ابتدا `FEATURE_EXPORT_IMPORT.md` را بخوانید تا با معماری آشنا شوید

---

## 📁 ساختار پروژه

```
goalpad/
├── 📖 START_HERE.md          ← همین فایل
├── ⚡ QUICKSTART.md           ← دستورات سریع
├── 🔧 SETUP_GUIDE.md          ← راهنمای کامل
├── 📋 CHEATSHEET.md           ← چیت شیت
├── 📦 FEATURE_EXPORT_IMPORT.md ← Feature docs
├── 🧪 INTEGRATION_GUIDE.md    ← تست و integration
│
├── lib/                       ← کدهای اصلی
│   ├── main.dart
│   └── features/journal/
│       ├── models/            ← Goal, Task, Habit, JournalEntry
│       ├── data/local/        ← Hive boxes + Export service
│       ├── logic/             ← Riverpod providers
│       └── ui/                ← صفحات و widgets
│
├── android/                   ← تنظیمات Android
│   └── app/src/main/
│       ├── AndroidManifest.xml ← Permissions
│       └── res/xml/
│           └── file_paths.xml  ← FileProvider config
│
├── test/                      ← تست‌ها
│   ├── export_import_test.dart
│   ├── goal_crud_test.dart
│   └── habit_tick_test.dart
│
└── pubspec.yaml               ← Dependencies
```

---

## 🎓 مراحل یادگیری پیشنهادی

```
روز 1: Setup
└─ SETUP_GUIDE.md → نصب Flutter → اجرای پروژه

روز 2: آشنایی
└─ INTEGRATION_GUIDE.md → تست features → درک UI

روز 3: کد خوانی
└─ FEATURE_EXPORT_IMPORT.md → فهم معماری → بررسی models

روز 4+: توسعه
└─ Feature جدید (Notifications, Progress Tracking)
```

---

## 🆘 در صورت مشکل

### 1️⃣ **ابتدا چک کنید:**

```powershell
flutter doctor -v
```

اگر همه چیز OK است → مشکل در پروژه است  
اگر خطا دارد → مشکل در Flutter SDK است

### 2️⃣ **خطای رایج:**

| علامت | راهنما |
|-------|---------|
| `flutter not recognized` | SETUP_GUIDE.md → بخش 2 |
| `*.g.dart not found` | QUICKSTART.md → بخش "رفع خطا" |
| `Gradle failed` | SETUP_GUIDE.md → بخش 10 |
| `Export نمی‌شود` | INTEGRATION_GUIDE.md → عیب‌یابی |

### 3️⃣ **هیچ کدام کار نکرد؟**

```powershell
# Reset کامل:
flutter clean
flutter pub cache repair
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 🎉 آماده‌اید؟

### اگر Flutter نصب نیست:
👉 [SETUP_GUIDE.md](./SETUP_GUIDE.md) را باز کنید

### اگر Flutter نصب است:
👉 [QUICKSTART.md](./QUICKSTART.md) را باز کنید

### اگر فقط می‌خواهید یادآوری سریع:
👉 [CHEATSHEET.md](./CHEATSHEET.md) را باز کنید

---

## 📞 کمک و پشتیبانی

- 🐛 **Bug report:** GitHub Issues
- 💡 **Feature request:** GitHub Discussions
- 📖 **Documentation:** فایل‌های MD در پروژه
- 💬 **Community:** Flutter Discord / Reddit

---

**موفق باشید! 🚀**

---

_آخرین بروزرسانی: October 2025_  
_نسخه: 1.0.0_  
_Flutter: 3.22+_

