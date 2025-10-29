import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

/// سرویس مدیریت پروفایل و آن‌بوردینگ
class ProfileService {
  static const _kOnboarded = 'onboarded';
  static const _kProfile = 'profile_json';

  /// چک آن‌بوردینگ
  Future<bool> isOnboarded() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_kOnboarded) ?? false;
  }

  /// تنظیم آن‌بوردینگ
  Future<void> setOnboarded(bool value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kOnboarded, value);
  }

  /// بارگذاری پروفایل
  Future<UserProfile?> loadProfile() async {
    final sp = await SharedPreferences.getInstance();
    final json = sp.getString(_kProfile);
    if (json == null) return null;
    try {
      return UserProfile.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  /// ذخیره پروفایل
  Future<void> saveProfile(UserProfile profile) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kProfile, profile.toJson());
  }

  /// پاک کردن همه داده‌ها
  Future<void> resetAll() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kOnboarded);
    await sp.remove(_kProfile);
  }
}
