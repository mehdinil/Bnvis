# GoalPad

A Flutter app for goals, habits, and journaling with offline-first architecture.

## Features

- **Goals Management**: Create, track, and manage your goals
- **Habit Tracking**: Build and maintain daily/weekly habits with streak tracking
- **Journal Entries**: Record daily thoughts and mood
- **Offline-First**: All data stored locally using Hive
- **Material 3 Design**: Modern UI with Material Design 3

## Tech Stack

- Flutter with null-safety
- Riverpod for state management
- Hive for local storage
- Material 3 design system

## Setup

1. **Install Flutter** (if not already installed)
   ```bash
   # Download from https://flutter.dev/docs/get-started/install
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  main.dart
  features/journal/
    data/local/
      hive_boxes.dart
    models/
      goal.dart
      task.dart
      habit.dart
      journal_entry.dart
    logic/
      providers.dart
    ui/
      app_shell.dart
      pages/
        goals_page.dart
        journal_page.dart
        habits_page.dart
```

## Data Storage

- **Location**: `~/Documents/` (platform-specific)
- **Format**: Hive database files
- **Backup**: Copy the entire app data directory

## Development

- **State Management**: Riverpod with StateNotifier
- **Local Storage**: Hive with generated adapters
- **Testing**: Flutter test framework
- **Code Generation**: build_runner for Hive adapters

## Next Steps

- Add goal detail page with task management
- Implement habit frequency tracking
- Add journal entry editing
- Add local notifications for reminders

