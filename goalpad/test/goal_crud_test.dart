import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:goalpad/features/journal/models/goal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(GoalStatusAdapter())
      ..registerAdapter(GoalAdapter());
  });

  test('Goal CRUD in memory', () async {
    final box = await Hive.openBox<Goal>('goals_test');
    final id = const Uuid().v4();
    final g = Goal(id: id, title: 'Test Goal', priority: 2, status: GoalStatus.active);
    await box.put(id, g);
    expect(box.values.length, 1);
    final g2 = box.get(id)!;
    expect(g2.title, 'Test Goal');
    await box.delete(id);
    expect(box.values, isEmpty);
    await box.close();
  });
}
