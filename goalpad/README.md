# Benevis - GoalPad with Biometric Authentication

A Flutter app for goals, habits, and journaling with beautiful Benevis design and biometric authentication.

## 🚀 Features

- **Biometric Authentication** - Touch ID/Fingerprint support
- **PIN Fallback** - Alternative authentication method
- **Beautiful UI** - Modern gradient design inspired by Benevis
- **Goal Tracking** - Set and track personal goals
- **Habit Management** - Build and maintain good habits
- **Journal Entries** - Record daily thoughts and progress

## 📱 Screenshots

The app features a stunning authentication screen with:
- Gradient background (blue to purple)
- Biometric authentication with Touch ID
- PIN fallback option
- Modern, clean design

## 🛠️ Setup & Build

### Prerequisites
- Flutter SDK 3.4.0 or higher
- Android Studio (for APK building)
- Android device with biometric sensor (optional)

### Local Development

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

### Building APK

#### Debug APK:
```bash
flutter build apk
```
**Output:** `build/app/outputs/flutter-apk/app-debug.apk`

#### Release APK:
```bash
flutter build apk --release
```
**Output:** `build/app/outputs/flutter-apk/app-release.apk`

## 🔧 Configuration

### Android Settings
- **minSdkVersion:** 23 (Android 6.0+)
- **compileSdkVersion:** 34
- **Permissions:** USE_BIOMETRIC, USE_FINGERPRINT

### Authentication
- **Biometric:** Touch ID/Fingerprint (primary)
- **PIN:** 4-digit fallback (default: 1234)
- **State:** Persistent with SharedPreferences

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point with AuthWrapper
├── features/journal/
│   ├── ui/
│   │   ├── pages/
│   │   │   ├── auth_page.dart          # Biometric authentication
│   │   │   ├── pin_login_page.dart    # PIN authentication
│   │   │   └── app_shell.dart         # Main app interface
│   │   └── widgets/                   # Reusable UI components
│   ├── models/                        # Data models
│   ├── logic/                         # Business logic
│   └── data/                          # Data layer
```

## 🎨 Design System

### Colors
- **Primary Gradient:** #1E3A8A → #7C3AED
- **Accent:** #7C3AED (Purple)
- **Text:** White/White70
- **Background:** Dark gradient

### Typography
- **Brand:** 32px, Bold
- **Title:** 28px, Bold
- **Body:** 16px, Regular
- **Caption:** 14px, Regular

## 🔐 Security Features

- **Biometric Authentication** - Secure device-based authentication
- **PIN Fallback** - Alternative when biometric unavailable
- **Session Management** - Persistent authentication state
- **Secure Storage** - SharedPreferences for auth state

## 🚨 Troubleshooting

### Common Issues

1. **"PowerShell executable not found"**
   - Use Command Prompt instead of PowerShell
   - Or run: `cmd /c "flutter build apk"`

2. **Biometric not working**
   - Check device has biometric sensor
   - Ensure permissions are granted
   - Use PIN fallback option

3. **Build fails**
   - Clean project: `flutter clean`
   - Get dependencies: `flutter pub get`
   - Try again: `flutter build apk`

### Build Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build apk --release

# Check Flutter installation
flutter doctor -v
```

## 📦 APK Output

After successful build, find your APK at:
```
build/app/outputs/flutter-apk/
├── app-debug.apk      # Debug version
└── app-release.apk    # Release version
```

## 🎯 Next Steps

1. **Customize PIN** - Implement secure PIN management
2. **Add Themes** - Light/dark mode support
3. **Cloud Sync** - Backup and sync data
4. **Notifications** - Goal and habit reminders

## 📄 License

This project is licensed under the MIT License.

---

**Built with ❤️ using Flutter & Benevis Design System**