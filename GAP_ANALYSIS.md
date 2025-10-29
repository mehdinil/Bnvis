# ✅ جمع‌بندی بی‌رحمانه (Gap Analysis)

> **تاریخ:** 2025-10-29  
> **وضعیت فعلی:** MVP Scaffold تکمیل شد، اما Production-Ready نیست  
> **هدف:** شناسایی شکاف‌ها و تعریف معیار پذیرش واقعی

---

## 🚨 **چیزهایی که هنوز احتمالاً جاشون خالیه یا باید محکم‌تر شه:**

### 1️⃣ **State Management پایدار**
- [ ] Riverpod به‌درستی Scoped شده؟
- [ ] Provider lifecycle برای صفحات (Home/Journal/Goals) لیک نمی‌دهد؟
- [ ] Auto-dispose providers برای جلوگیری از memory leak
- [ ] Loading/Error states برای همه async operations
- [ ] **وضعیت فعلی:** ❌ هیچ Provider نداریم، فقط StatefulWidget استفاده شده

### 2️⃣ **Persistence واقعی**
- [ ] Isar/Drift؟ الان CRUDها خطای I/O، کانکارنسی، و مهاجرت اسکیما را چطور هندل می‌کنند؟
- [ ] Schema versioning با migration strategy
- [ ] Transaction handling برای complex writes
- [ ] Error recovery و fallback mechanisms
- [ ] **وضعیت فعلی:** ⚠️ Isar models ساخته شده، اما بدون migration strategy و error handling

### 3️⃣ **Onboarding پویا**
- [ ] نسخهٔ «دیالوگ‌محور» با بازگشت‌پذیری (Back stack) و ذخیرهٔ مرحله‌ای (autosave) کامل است؟
- [ ] Resume از نیمه راه (وقتی اپ بسته می‌شود)
- [ ] Skip option برای کاربران عجول
- [ ] Validation هر step قبل از ادامه
- [ ] **وضعیت فعلی:** ✅ ویزارد 7 مرحله‌ای ساخته شده، ⚠️ اما بدون autosave و resume

### 4️⃣ **Theme Engine واقعی**
- [ ] فقط سوئیچ Light/Dark یا کنترل کامل ColorScheme/Radius/Font هم دارد؟
- [ ] Dynamic theme switching بدون restart
- [ ] Custom color picker
- [ ] Font selector (IRANSans, Vazir, Inter)
- [ ] Radius/Elevation customization
- [ ] **وضعیت فعلی:** ✅ تم Dark ساخته شده، ❌ اما بدون customization UI

### 5️⃣ **AI Insight لوکال**
- [ ] مدل/قواعد تحلیلی مشخص؟ fallback وقتی متن خالی/طولانی/غیر فارسی است؟
- [ ] Sentiment analysis (rule-based)
- [ ] Keyword extraction
- [ ] Context-aware suggestions
- [ ] Graceful degradation برای edge cases
- [ ] **وضعیت فعلی:** ✅ Mock service با 4-5 قاعده ساده، ⚠️ اما بدون fallback محکم

### 6️⃣ **RTL/I18n**
- [ ] جهت‌دهی، اعداد فارسی، تاریخ جلالی، و سوئیچ زبانی بدون ری‌استارت؟
- [ ] Persian number formatting
- [ ] Jalali date picker
- [ ] Dynamic locale switching
- [ ] All texts from ARB files
- [ ] **وضعیت فعلی:** ✅ RTL support، ❌ اما hardcoded strings و بدون Jalali

### 7️⃣ **خطا/Crash Handling**
- [ ] global `FlutterError.onError`، log محلی، گزارش کاربر؟
- [ ] Error boundary widgets
- [ ] Logging service (local + optional remote)
- [ ] User-friendly error messages
- [ ] Retry mechanisms
- [ ] **وضعیت فعلی:** ❌ هیچ error handling سیستماتیک نداریم

### 8️⃣ **Security**
- [ ] قفل بیومتریک/PIN، رمزگذاری لوکال، feature flag برای دسترسی حساس؟
- [ ] Biometric authentication (local_auth)
- [ ] PIN/Pattern lock
- [ ] Encrypted storage (flutter_secure_storage)
- [ ] Auto-lock بعد از inactivity
- [ ] **وضعیت فعلی:** ❌ هیچ security layer نداریم

### 9️⃣ **Testing**
- [ ] حداقل ۸–۱۰ تست واحد برای core (goals/habits/journal)، و ۳–۴ تست ویجت برای Onboarding/Dashboard.
- [ ] Unit tests: Services (CRUD, streak calculation, progress)
- [ ] Widget tests: Onboarding flow, Dashboard, Forms
- [ ] Integration tests: E2E user flows
- [ ] **وضعیت فعلی:** ❌ صفر تست نوشته شده

### 🔟 **CI/CD**
- [ ] workflow فقط build می‌دهد یا lint/test/format هم اجباری است؟
- [ ] Lint enforcement (flutter analyze)
- [ ] Format check (flutter format)
- [ ] Test execution (flutter test)
- [ ] Code coverage reporting
- [ ] **وضعیت فعلی:** ✅ Build workflow موجود، ❌ اما بدون lint/test

### 1️⃣1️⃣ **قابلیت Export/Import**
- [ ] نسخه‌گذاری JSON + merge ایمن دارد یا صرفاً dump می‌کند؟
- [ ] Schema versioning
- [ ] Conflict resolution
- [ ] Incremental backup
- [ ] Restore validation
- [ ] **وضعیت فعلی:** ❌ هیچ export/import نداریم

---

## 🎯 **معیار پذیرش (Acceptance) برای اعلام «MVP واقعاً آماده»**

### ✅ **Must-Have (Blocker برای Launch)**

1. **آن‌بوردینگ دیالوگی**: تکمیل‌شده، قابل ادامه از نیمه، و با دکمهٔ «میهمان».
   - **Status:** ⚠️ Partial (wizard موجود، autosave/resume نداریم)

2. **Dashboard زنده**: آمار اهداف/عادات/ژورنال + Quick Add بدون کرش.
   - **Status:** ✅ Stats موجود، ⚠️ Quick Add نداریم

3. **Goals/Habits/Journal**: CRUD کامل + Undo ساده + Empty state منطقی.
   - **Status:** ✅ CRUD موجود، ❌ Undo نداریم

4. **AI Insight لوکال**: حداقل ۴ قاعدهٔ محتوایی + fallback امن.
   - **Status:** ✅ 10+ quotes/insights، ⚠️ fallback ساده

5. **Theme Engine**: تغییر رنگ/فونت/Radius و حفظ تنظیمات بعد از ری‌لانچ.
   - **Status:** ❌ فقط تم Dark hardcoded

6. **Export/Import**: JSON نسخه‌دار با merge مطابق شناسه‌ها.
   - **Status:** ❌ وجود ندارد

7. **Security**: قفل اپ (Biometric/PIN) و حذف امن داده‌ها (factory reset).
   - **Status:** ❌ وجود ندارد

8. **Build**: دو APK (Demo/Normal) + lint/test در CI سبز.
   - **Status:** ✅ دو APK، ❌ lint/test در CI نداریم

### 🟡 **Should-Have (برای Beta)**

- Notification system برای یادآوری عادات
- Statistics dashboard با charts
- Skills module
- Finance module basic
- Search functionality

### 🔵 **Nice-to-Have (Post-Launch)**

- Cloud sync (Google Drive)
- Collaborative goals
- Social features
- Advanced AI (TFLite)
- Widget support

---

## 🛠 **سه معماریِ عملی (با مزایا/معایب)**

### **A) Riverpod + Isar (پیشنهادی برای MVP)** ⭐

**مزایا:**
- ✅ ساده و سریع
- ✅ آفلاین‌فرست
- ✅ کد تمیز و type-safe
- ✅ Performance عالی روی موبایل
- ✅ Code generation کم

**معایب:**
- ⚠️ مهاجرت اسکیما باید با دقت نوشته شود
- ⚠️ Query capabilities محدودتر از SQL
- ⚠️ Community کوچک‌تر

**تصمیم:** ✅ **پیاده‌سازی شده**

---

### **B) BLoC + Drift/SQLite**

**مزایا:**
- ✅ الگوی تمیز لایه‌ها
- ✅ SQL قدرت‌مند برای گزارش‌ها
- ✅ مهاجرت‌ها robust
- ✅ Community بزرگ

**معایب:**
- ❌ سربار کدنویسی زیاد
- ❌ سرعت کمتر از Isar روی موبایل‌های ضعیف
- ❌ Boilerplate زیاد

**تصمیم:** ❌ برای Finance module در Phase 2 بررسی شود

---

### **C) Riverpod + Hive + Sync آینده**

**مزایا:**
- ✅ راه‌اندازی ساده
- ✅ مهاجرت‌ها آسان‌تر از صفر تا یکی
- ✅ Community بزرگ
- ✅ Lightweight

**معایب:**
- ❌ نسبت به Isar کندتر در Queryهای سنگین
- ❌ Type-safety کمتر
- ❌ Index limitations

**تصمیم:** ❌ Isar را انتخاب کردیم

---

## 🔧 **چک‌لیست اصلاح سریع (قبلِ اعلام Production-Ready)**

### **Phase 1A: Critical Fixes (۱-۲ روز)**

- [ ] **Cleanup برند**: حذف هر اثری از `goalpad/tablo` (کد، آیکون، اسپلش، `applicationId`)
- [ ] **Error Handling**: Global error boundary + try-catch در همه async ops
- [ ] **Riverpod Integration**: تبدیل StatefulWidgets به ConsumerWidget
- [ ] **Onboarding Resume**: Autosave هر step در SharedPrefs
- [ ] **Undo Support**: SnackBar با action برای Goals/Habits/Journal
- [ ] **CI Lint/Test**: اضافه کردن flutter analyze + flutter test به workflow

### **Phase 1B: Core Features (۲-۳ روز)**

- [ ] **Theme Engine**: UI برای تغییر Light/Dark + Primary color
- [ ] **Export/Import**: JSON با version + merge logic
- [ ] **Security Basic**: PIN lock با secure_storage
- [ ] **I18n**: ARB files + locale switching
- [ ] **Jalali Date**: جایگزینی Gregorian با Shamsi

### **Phase 1C: Quality (۱-۲ روز)**

- [ ] **Unit Tests**: 8+ tests برای services
- [ ] **Widget Tests**: 3+ tests برای key flows
- [ ] **Documentation**: README + inline docs
- [ ] **Performance**: Profile و optimize heavy widgets

---

## 📊 **Gap Score (واقع‌بینانه)**

| Category | Score | Status |
|----------|-------|--------|
| Architecture | 6/10 | ⚠️ Isar موجود، Riverpod نه |
| State Management | 3/10 | ❌ StatefulWidget ساده |
| Persistence | 5/10 | ⚠️ Models ok، migration/error نه |
| UI/UX | 7/10 | ✅ خوب، اما بدون empty states |
| Security | 0/10 | ❌ هیچی |
| Testing | 0/10 | ❌ صفر تست |
| I18n/RTL | 4/10 | ⚠️ RTL ok، localization نه |
| Error Handling | 1/10 | ❌ فقط UI errors |
| CI/CD | 5/10 | ⚠️ Build ok، lint/test نه |
| Documentation | 6/10 | ✅ VISION/ROADMAP خوب |

**Overall MVP Readiness: 37/100** 🟠

---

## 🎯 **تصمیم استراتژیک**

### **Option A: Quick Launch (با Disclaimer)** 🟡
- فقط Phase 1A را تکمیل کن (2 روز)
- Launch با label "Early Access Beta"
- Accept محدودیت‌ها و bugs
- **Risk:** Churn بالا، بازخورد منفی

### **Option B: Production-Grade Launch** ⭐ **پیشنهادی**
- Phase 1A + 1B + 1C را تکمیل کن (5-6 روز)
- Launch با confidence
- Stability و Security تضمین شده
- **Benefit:** Retention بالا، Trust

### **Option C: Pivot to POC**
- همین MVP scaffold را POC بدان
- برای پیچ به investors/early adopters نشان بده
- بعد از validation، rebuild با architecture محکم
- **Risk:** زمان بیشتر، اما product-market fit بهتر

---

## 🗺️ **مایل‌استون‌های اجرایی (۵-۶ روزه برای Option B)**

### **D1: Architecture Refactor**
- Riverpod providers برای Goals/Habits/Journal
- Error handling layer
- Loading states
- 4 ساعت

### **D2: Onboarding + Theme**
- Autosave/resume
- Theme engine با UI
- 6 ساعت

### **D3: Security + Export**
- PIN/Biometric lock
- Export/Import با versioning
- 6 ساعت

### **D4-D5: Testing + I18n**
- 8+ unit tests
- 3+ widget tests
- ARB files
- Jalali dates
- 10 ساعت

### **D6: Polish + CI**
- Lint/format/test در CI
- Documentation
- Final smoke test
- 4 ساعت

**Total: ~30 ساعت کاری**

---

## 🧠 **پرامپت نهایی Cursor (نسخهٔ Production-Grade)**

> این پرامپت را در `CURSOR_PROMPT_PRODUCTION.md` ذخیره می‌کنم برای اجرای مرحله بعد.

---

**تاریخ بررسی بعدی:** D6 (بعد از اتمام Phase 1C)  
**Reviewer:** Co-founder (مهدی)  
**وضعیت:** 🟠 در حال توسعه
