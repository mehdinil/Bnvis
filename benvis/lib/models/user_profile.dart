import 'dart:convert';

/// مدل پروفایل کاربر (گسترش یافته)
class UserProfile {
  final String fullName;
  final String? email;
  final String? phone;

  // داده‌های آن‌بوردینگ
  final String? mainGoal; // هدف اصلی زندگی
  final List<String>? favoriteHabits; // عادات مورد علاقه
  final List<String>? skillsToLearn; // مهارت‌هایی که می‌خواهد یاد بگیرد
  final String? sleepTime; // HH:mm
  final String? wakeTime; // HH:mm
  final String? userType; // student, employee, freelancer, manager
  final String? themeName; // neon, purple, minimal, light

  const UserProfile({
    required this.fullName,
    this.email,
    this.phone,
    this.mainGoal,
    this.favoriteHabits,
    this.skillsToLearn,
    this.sleepTime,
    this.wakeTime,
    this.userType,
    this.themeName,
  });

  /// تبدیل به Map
  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'mainGoal': mainGoal,
        'favoriteHabits': favoriteHabits,
        'skillsToLearn': skillsToLearn,
        'sleepTime': sleepTime,
        'wakeTime': wakeTime,
        'userType': userType,
        'themeName': themeName,
      };

  /// تبدیل به JSON string
  String toJson() => json.encode(toMap());

  /// ساخت از JSON string
  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  /// ساخت از Map
  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
        fullName: (map['fullName'] ?? '').toString(),
        email: (map['email'] as String?)?.trim(),
        phone: (map['phone'] as String?)?.trim(),
        mainGoal: map['mainGoal'] as String?,
        favoriteHabits: (map['favoriteHabits'] as List?)?.cast<String>(),
        skillsToLearn: (map['skillsToLearn'] as List?)?.cast<String>(),
        sleepTime: map['sleepTime'] as String?,
        wakeTime: map['wakeTime'] as String?,
        userType: map['userType'] as String?,
        themeName: map['themeName'] as String?,
      );

  /// کپی با تغییرات
  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? mainGoal,
    List<String>? favoriteHabits,
    List<String>? skillsToLearn,
    String? sleepTime,
    String? wakeTime,
    String? userType,
    String? themeName,
  }) =>
      UserProfile(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        mainGoal: mainGoal ?? this.mainGoal,
        favoriteHabits: favoriteHabits ?? this.favoriteHabits,
        skillsToLearn: skillsToLearn ?? this.skillsToLearn,
        sleepTime: sleepTime ?? this.sleepTime,
        wakeTime: wakeTime ?? this.wakeTime,
        userType: userType ?? this.userType,
        themeName: themeName ?? this.themeName,
      );
}
