# GoalPad - Useful Commands

## Setup Commands

```bash
# Install dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Development Commands

```bash
# Run the app
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Hot reload (while app is running)
# Press 'r' in terminal or use IDE hot reload
```

## Testing Commands

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/goal_crud_test.dart

# Run tests with coverage
flutter test --coverage
```

## Code Quality Commands

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Check for issues
flutter doctor
```

## Build Commands

```bash
# Build APK (Android)
flutter build apk

# Build APK in release mode
flutter build apk --release

# Build for web
flutter build web

# Build for Windows
flutter build windows
```

## Database Commands

```bash
# Clear Hive database (development only)
# Delete the app data directory on your device/emulator
# Android: /data/data/com.example.goalpad/app_flutter/
# iOS: Documents directory in app sandbox
```

## Troubleshooting

```bash
# If build_runner fails
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

# If dependencies are corrupted
flutter clean
flutter pub get

# Check Flutter installation
flutter doctor -v
```

