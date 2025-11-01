# Benvis — Your Life OS (Flutter)

اپلیکیشن **بنویس**: مدیریت اهداف و عادات، پیگیری مهارت‌ها، KPIهای کسب‌وکار و کوچ هوش‌مصنوعی—همه در یک داشبورد مدرن با تم تیره و گلس‌مورفیسم.
**بستهٔ اندروید:** `com.benvis.app` • **پوشهٔ پروژه:** `benvis/`

---

## ✨ قابلیت‌ها
- **داشبورد هوشمند:** درصد پیشرفت، streak، درآمد/متریک‌ها و اهداف فعال
- **اهداف و عادات:** ایجاد/ویرایش، پیگیری روزانه/هفتگی، نوار پیشرفت
- **مهارت‌ها:** لیست مهارت‌های جدید و میزان پیشرفت هر کدام
- **کسب‌وکار:** کارت‌های KPI (مثلاً بازاریابی، محصول، مالی)
- **AI Coach:** بخش گفتگو برای راهنمایی و برنامه‌ریزی
- **امنیت ورود:** اثرانگشت/Face/PIN (در دستگاه‌های پشتیبانی‌شده)
- **RTL و چندزبانه:** فارسی/انگلیسی (RTL پیش‌فرض)
- **PWA Ready:** قابل نصب روی وب با استراتژی آفلاین
- **تم و برندینگ:** رنگ‌های بنفش/آبی، کارت‌های شیشه‌ای، Material 3

---

## 🧱 Tech Stack
- **Flutter (Dart 3، Material 3)**
- **State Management:** (قابل‌گسترش؛ در حال حاضر ساده/لوکال)
- **Local Store:** `shared_preferences` (قابل ارتقا به Hive)
- **Biometrics:** `local_auth` (در صورت نیاز)
- **CI/CD:** GitHub Actions → خروجی **APK** در Artifacts

> ساختار پوشه‌ها: کل کد اپ در `benvis/` است (اگر قبلاً `goalpad/` داشته‌اید، به `benvis/` منتقل شده).

---

## 🚀 شروع سریع

### پیش‌نیازها
- Flutter stable (Dart 3)
- Android SDK 34 ، Java 17

### کلون و اجرا
```bash
git clone https://github.com/mehdinil/Bnvis.git
cd Bnvis/benvis
flutter pub get
flutter run -d android
```

### ساخت APK محلی
```bash
cd Bnvis/benvis
flutter clean
flutter build apk --release --split-per-abi
```

خروجی در مسیر `benvis/build/app/outputs/flutter-apk/` قرار می‌گیرد. سه فایل اصلی (`app-armeabi-v7a-release.apk`،
`app-arm64-v8a-release.apk` و `app-x86_64-release.apk`) برای معماری‌های مختلف تولید می‌شود؛ می‌توانید بنابر نیاز آن‌ها را مستقیماً نصب کنید یا با ابزارهایی مانند `bundletool` در یک بستهٔ واحد ادغام نمایید.

### دریافت خروجی از GitHub Actions
Workflow آمادهٔ **BENVIS Build** روی شاخهٔ `main` به‌صورت خودکار اجرا می‌شود و خروجی را به‌عنوان Artifact نگه می‌دارد.

1. به تب **Actions** در ریپو بروید و Workflow با نام *BENVIS Build* را باز کنید.
2. آخرین اجرای موفق را انتخاب کنید یا با **Run workflow** اجرا را دستی آغاز کنید.
3. در انتهای صفحه، از بخش **Artifacts** بستهٔ `benvis-android` را دانلود کنید؛ این بسته شامل همهٔ APKهای تولیدشده است.

> در صورت نیاز به AAB نیز می‌توانید دستور `flutter build appbundle --release` را محلی اجرا کنید یا آن را به Workflow بیفزایید.
