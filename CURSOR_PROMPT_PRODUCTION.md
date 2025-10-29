# 🧠 پرامپت نهایی Cursor — Benevis Life OS (نسخهٔ Production-Grade)

> **مخاطب:** Claude 4.5 Sonnet Agent در Cursor  
> **هدف:** تکمیل MVP مطابق معیار پذیرش و تحویل Production-Ready App  
> **Timeline:** 5-6 روز (30 ساعت کاری)

---

## 📋 System / Role

```
تو مهندس ارشد Flutter/DevOps هستی با تخصص در:
- Clean Architecture
- Test-Driven Development
- Security Best Practices
- Performance Optimization

هدف: تکمیل Benevis Life OS مطابق معیار پذیرش زیر و تحویل دو APK (Demo/Normal) + CI با lint/test.
```

---

## ✅ Acceptance Criteria (واجب)

### 1️⃣ **Onboarding دیالوگی با Resume**
- [ ] 7-step wizard با Progress indicator
- [ ] Autosave هر step در SharedPreferences
- [ ] Resume از آخرین step کامل شده
- [ ] دکمهٔ "استفاده به‌صورت میهمان"
- [ ] Validation قبل از next
- [ ] Back button support

### 2️⃣ **Dashboard زنده**
- [ ] Real-time counters: اهداف فعال، عادات امروز، streak بهترین، تعداد ژورنال
- [ ] Quick Add FAB با bottom sheet (Goal/Habit/Journal)
- [ ] AI Coach card با daily quote
- [ ] Refresh on resume
- [ ] Error handling برای data load
- [ ] Loading states

### 3️⃣ **Goals/Habits/Journal CRUD**
- [ ] Complete CRUD operations
- [ ] Undo via SnackBar action (5 seconds)
- [ ] Empty states با illustration + CTA
- [ ] Loading states
- [ ] Error states با retry
- [ ] Form validation
- [ ] Optimistic updates

### 4️⃣ **AI Insight لوکال**
- [ ] 4+ قاعدهٔ sentiment (مثبت، منفی، خنثی، انرژیک)
- [ ] Keyword detection (ورزش، مطالعه، کار، استراحت)
- [ ] Context-aware suggestions
- [ ] Fallback برای: empty text، very long text، non-Persian
- [ ] Caching insights
- [ ] Performance optimization (<100ms)

### 5️⃣ **Theme Engine**
- [ ] Light/Dark mode toggle
- [ ] Primary color picker (5 presets + custom)
- [ ] Font selector (IRANSans, Vazir, Inter)
- [ ] Border radius slider (8-24dp)
- [ ] Live preview
- [ ] Persist in SharedPrefs
- [ ] Apply without restart

### 6️⃣ **Export/Import**
- [ ] Schema version: `SCHEMA_VERSION = 1`
- [ ] JSON structure: `{version, profile, theme, goals[], habits[], journal[]}`
- [ ] Export to file with timestamp
- [ ] Import with version check
- [ ] Merge logic: append new, update existing (by id), skip duplicates
- [ ] Validation + error handling
- [ ] Progress indicator

### 7️⃣ **Security**
- [ ] PIN lock (4-6 digits) با flutter_secure_storage
- [ ] Biometric authentication (fallback to PIN)
- [ ] Auto-lock after 5 min inactivity
- [ ] Lock on app resume from background
- [ ] Factory reset: wipe all data + secure storage
- [ ] Settings UI

### 8️⃣ **CI/CD Pipeline**
- [ ] Job 1: Lint (`flutter analyze`)
- [ ] Job 2: Format check (`flutter format --set-exit-if-changed .`)
- [ ] Job 3: Test (`flutter test --coverage`)
- [ ] Job 4: Build Demo APK
- [ ] Job 5: Build Normal APK
- [ ] Upload artifacts + coverage report
- [ ] Fail fast if lint/test fails

---

## 🏗️ Architecture & Stack

### **State Management**
- **Riverpod 2.5.1** (compatible با Isar)
- Providers:
  - `goalsProvider`: Stream<List<Goal>>
  - `habitsProvider`: Stream<List<Habit>>
  - `journalProvider`: Stream<List<JournalEntry>>
  - `themeProvider`: StateNotifier<ThemeState>
  - `profileProvider`: FutureProvider<UserProfile>
- Auto-dispose برای memory efficiency
- Family providers برای single items

### **Storage**
- **Isar 3.1.0+1**: Goals, Habits, Journal
- **SharedPreferences**: Theme, Profile, Onboarding state
- **Flutter Secure Storage**: PIN hash, Biometric token

### **Testing**
- **flutter_test**: Unit + Widget tests
- **mocktail**: Mocking dependencies
- **isar_test**: Database tests

### **Packages**
```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  shared_preferences: ^2.3.2
  flutter_secure_storage: ^9.2.2
  local_auth: ^2.3.0
  intl: ^0.19.0
  shamsi_date: ^1.0.1  # Jalali calendar
  file_picker: ^8.0.0
  share_plus: ^10.0.3
  path_provider: ^2.1.4

dev_dependencies:
  build_runner: ^2.4.13
  isar_generator: ^3.1.0+1
  flutter_launcher_icons: ^0.13.1
  mocktail: ^1.0.4
```

---

## 📂 Project Structure

```
lib/
  core/
    config/
      app_config.dart          # kDemoMode, kSchemaVersion
      theme_config.dart        # ThemePresets
    models/
      goal.dart, habit.dart, journal_entry.dart
      user_profile.dart
      theme_state.dart
    services/
      isar_service.dart
      ai_coach_service.dart
      export_service.dart
      security_service.dart
    providers/
      goals_provider.dart
      habits_provider.dart
      journal_provider.dart
      theme_provider.dart
      profile_provider.dart
  modules/
    onboarding/
      screens/smart_wizard.dart
      widgets/step_*.dart
      logic/onboarding_state.dart
    goals/
      screens/goals_screen.dart
      widgets/goal_card.dart, goal_dialog.dart
      logic/goals_repository.dart
    habits/
      screens/habits_screen.dart
      widgets/habit_card.dart, streak_widget.dart
      logic/habits_repository.dart
    journal/
      screens/journal_screen.dart, entry_screen.dart
      widgets/mood_selector.dart, ai_insight_card.dart
      logic/journal_repository.dart
    dashboard/
      screens/home_screen.dart
      widgets/stats_card.dart, quick_add_sheet.dart, coach_card.dart
    settings/
      screens/settings_screen.dart
      widgets/theme_picker.dart, security_settings.dart
  shared/
    widgets/
      glass_card.dart
      empty_state.dart
      loading_state.dart
      error_state.dart
    utils/
      date_utils.dart
      validators.dart
  main.dart
```

---

## 🎯 Tasks (به ترتیب اولویت)

### **Phase 1A: Critical Fixes (Day 1-2)**

#### ✅ Task 1.1: Riverpod Integration
```dart
// core/providers/goals_provider.dart
final goalsProvider = StreamProvider<List<Goal>>((ref) async* {
  final isar = await IsarService.getInstance();
  yield* isar.goals.where().watch(fireImmediately: true);
});

// Usage in GoalsScreen
class GoalsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsProvider);
    return goalsAsync.when(
      data: (goals) => _buildList(goals),
      loading: () => LoadingState(),
      error: (e, st) => ErrorState(error: e, onRetry: () => ref.refresh(goalsProvider)),
    );
  }
}
```

#### ✅ Task 1.2: Error Handling Layer
```dart
// core/services/error_handler.dart
class ErrorHandler {
  static void handleError(Object error, StackTrace stackTrace) {
    // Log locally
    debugPrint('Error: $error\n$stackTrace');
    // Show user-friendly message
    // Optional: send to crash reporting
  }
}

// main.dart
void main() {
  FlutterError.onError = (details) {
    ErrorHandler.handleError(details.exception, details.stack ?? StackTrace.current);
  };
  runApp(ProviderScope(child: BenvisApp()));
}
```

#### ✅ Task 1.3: Onboarding Resume
```dart
// modules/onboarding/logic/onboarding_state.dart
class OnboardingState extends StateNotifier<int> {
  OnboardingState() : super(0) {
    _loadStep();
  }
  
  Future<void> _loadStep() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('onboarding_step') ?? 0;
  }
  
  Future<void> saveStep(int step) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onboarding_step', step);
    state = step;
  }
}
```

#### ✅ Task 1.4: Undo Support
```dart
// shared/mixins/undo_mixin.dart
mixin UndoMixin<T extends StatefulWidget> on State<T> {
  void showUndo(String message, VoidCallback onUndo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'بازگردانی', onPressed: onUndo),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
```

### **Phase 1B: Core Features (Day 3-4)**

#### ✅ Task 2.1: Theme Engine
```dart
// core/models/theme_state.dart
@freezed
class ThemeState with _$ThemeState {
  factory ThemeState({
    @Default(ThemeMode.dark) ThemeMode mode,
    @Default(0xFF7C3AED) int primaryColor,
    @Default('IRANSans') String fontFamily,
    @Default(16.0) double borderRadius,
  }) = _ThemeState;
}

// core/providers/theme_provider.dart
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState()) {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Load from SharedPrefs
  }
  
  Future<void> updatePrimaryColor(int color) async {
    state = state.copyWith(primaryColor: color);
    await _saveTheme();
  }
}
```

#### ✅ Task 2.2: Export/Import
```dart
// core/services/export_service.dart
class ExportService {
  static const SCHEMA_VERSION = 1;
  
  Future<String> exportData() async {
    final isar = await IsarService.getInstance();
    final profile = await ProfileService().loadProfile();
    
    final data = {
      'version': SCHEMA_VERSION,
      'exportDate': DateTime.now().toIso8601String(),
      'profile': profile?.toMap(),
      'goals': await isar.goals.where().findAll().then((list) => list.map((g) => g.toJson()).toList()),
      'habits': await isar.habits.where().findAll().then((list) => list.map((h) => h.toJson()).toList()),
      'journal': await isar.journalEntrys.where().findAll().then((list) => list.map((j) => j.toJson()).toList()),
    };
    
    return jsonEncode(data);
  }
  
  Future<void> importData(String jsonString) async {
    final data = jsonDecode(jsonString);
    final version = data['version'] as int;
    
    if (version != SCHEMA_VERSION) {
      throw Exception('نسخه فایل پشتیبان سازگار نیست');
    }
    
    // Merge logic
    final isar = await IsarService.getInstance();
    await isar.writeTxn(() async {
      // Import goals
      for (var goalJson in data['goals']) {
        final goal = Goal.fromJson(goalJson);
        await isar.goals.put(goal);
      }
      // ... similar for habits and journal
    });
  }
}
```

#### ✅ Task 2.3: Security (PIN + Biometric)
```dart
// core/services/security_service.dart
class SecurityService {
  final _storage = FlutterSecureStorage();
  final _auth = LocalAuthentication();
  
  Future<bool> setupPIN(String pin) async {
    final hash = _hashPIN(pin);
    await _storage.write(key: 'pin_hash', value: hash);
    return true;
  }
  
  Future<bool> verifyPIN(String pin) async {
    final storedHash = await _storage.read(key: 'pin_hash');
    return storedHash == _hashPIN(pin);
  }
  
  Future<bool> authenticateWithBiometric() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'برای ادامه، احراز هویت کنید',
        options: AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      return false;
    }
  }
  
  String _hashPIN(String pin) {
    // Use crypto package for hashing
    return sha256.convert(utf8.encode(pin + 'salt')).toString();
  }
}
```

### **Phase 1C: Quality (Day 5-6)**

#### ✅ Task 3.1: Unit Tests
```dart
// test/services/goals_repository_test.dart
void main() {
  late Isar isar;
  late GoalsRepository repository;
  
  setUp(() async {
    isar = await Isar.open([GoalSchema], directory: '', name: 'test');
    repository = GoalsRepository(isar);
  });
  
  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });
  
  test('should create goal', () async {
    final goal = Goal()..title = 'Test'..category = GoalCategory.personal;
    await repository.create(goal);
    
    final goals = await repository.getAll();
    expect(goals.length, 1);
    expect(goals.first.title, 'Test');
  });
  
  test('should calculate progress', () async {
    final goal = Goal()..title = 'Test'..progress = 0.5;
    expect(goal.progressPercentage, 50);
  });
  
  // ... 6 more tests
}
```

#### ✅ Task 3.2: Widget Tests
```dart
// test/widgets/onboarding_test.dart
void main() {
  testWidgets('should resume from saved step', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: SmartOnboardingWizard()),
      ),
    );
    
    // Save step 3
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onboarding_step', 3);
    
    await tester.pumpAndSettle();
    
    // Should show step 3
    expect(find.text('چه مهارتی می‌خوای یاد بگیری؟'), findsOneWidget);
  });
}
```

#### ✅ Task 3.3: CI Workflow Update
```yaml
# .github/workflows/build.yml
name: Build & Test

on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter format --set-exit-if-changed .
  
  test:
    needs: analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
  
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      # ... existing build steps
```

---

## 🎨 Design Guidelines

### **از Canva:**
- رنگ پایه: `#5468FF` → `#C77DFF` (gradient)
- Glassmorphism: `blur(16px)`, `opacity(0.1)`
- Border radius: 16-20dp
- Shadows: `elevation: 4, color: rgba(0,0,0,0.1)`

### **Typography:**
- Heading: IRANSans Bold, 24-32sp
- Body: IRANSans Regular, 14-16sp
- Caption: 12sp, opacity 0.6

### **Colors:**
- Primary: `#7C3AED` (Purple)
- Secondary: `#38BDF8` (Blue)
- Success: `#10B981` (Green)
- Warning: `#F59E0B` (Orange)
- Error: `#EF4444` (Red)
- Background Dark: `#0B0F25`

---

## 📊 Definition of Done

### **Code Quality:**
- [ ] Zero lint warnings
- [ ] All tests passing
- [ ] Code coverage > 70%
- [ ] No TODO/FIXME comments
- [ ] All public APIs documented

### **Functionality:**
- [ ] All acceptance criteria met
- [ ] Smoke tested on real device
- [ ] No memory leaks (profiled)
- [ ] Works offline
- [ ] Handles edge cases

### **Documentation:**
- [ ] README updated with setup instructions
- [ ] API docs for services
- [ ] Architecture decision records
- [ ] Known issues documented

### **Deliverables:**
- [ ] Two APKs (Demo + Normal)
- [ ] CI passing (lint + test + build)
- [ ] Test coverage report
- [ ] Final gap analysis update

---

## 🚨 Constraints

1. **No Breaking Changes**: باید با داده‌های ساخته‌شده در نسخه قبلی سازگار باشد
2. **Backward Compatibility**: Export/Import باید با future versions کار کند
3. **Performance**: App startup < 2s, Frame time < 16ms
4. **Size**: APK size < 20MB per ABI
5. **Dependencies**: فقط stable packages، no alpha/beta

---

## 🎯 Success Metrics

| Metric | Target | Current |
|--------|--------|---------|
| Test Coverage | >70% | 0% |
| Lint Warnings | 0 | ? |
| Startup Time | <2s | ? |
| APK Size (arm64) | <20MB | ? |
| Crash Rate | <0.1% | N/A |

---

## 🗣️ Communication

**Daily Standup (خودگزارش):**
- چه کاری انجام شد؟
- چه مشکلی پیش آمد؟
- امروز چه کاری انجام می‌شود؟

**Final Report Format:**
```markdown
# Benevis Life OS — Production Release Report

## ✅ Completed
- [List all acceptance criteria met]

## ⚠️ Known Issues
- [List any remaining bugs/limitations]

## 📊 Metrics
- Test Coverage: X%
- APK Size: XMB
- Build Time: Xmin

## 🔮 Next Steps
- [Suggestions for Phase 2]
```

---

**این پرامپت را به Cursor بده و بگو: "Start production-grade implementation"**
