# Contributing to GoalPad

Thank you for your interest in contributing to GoalPad! This document provides guidelines for contributing to the project.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/goalpad.git
   cd goalpad
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Development Setup

### Prerequisites
- Flutter SDK 3.4.0 or higher
- Dart SDK (comes with Flutter)
- Git

### Running the App
```bash
flutter run
```

### Running Tests
```bash
flutter test
```

### Code Generation
After modifying Hive models, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Code Style

- Follow Dart/Flutter conventions
- Use `flutter analyze` to check for issues
- Prefer `const` constructors where possible
- Use meaningful variable and function names
- Add comments for complex logic

## Project Structure

```
lib/
├── main.dart
├── features/journal/
│   ├── data/local/          # Data layer
│   ├── models/              # Hive models
│   ├── logic/               # Riverpod providers
│   └── ui/                  # UI components
│       ├── pages/           # Screen widgets
│       └── widgets/         # Reusable widgets
```

## Pull Request Process

1. **Create a feature branch** from `main`
2. **Make your changes** following the code style
3. **Add tests** for new functionality
4. **Update documentation** if needed
5. **Run tests** to ensure everything works
6. **Submit a pull request** with a clear description

## Feature Requests

- Use GitHub Issues to suggest new features
- Provide clear descriptions and use cases
- Consider the app's offline-first nature
- Think about user experience and simplicity

## Bug Reports

When reporting bugs, please include:
- Steps to reproduce
- Expected behavior
- Actual behavior
- Device/OS information
- Screenshots if applicable

## Questions?

Feel free to open an issue for any questions or discussions!

