import 'dart:convert';

/// مدل پروفایل کاربر
class UserProfile {
  final String fullName;
  final String? email;
  final String? phone;

  const UserProfile({
    required this.fullName,
    this.email,
    this.phone,
  });

  /// تبدیل به Map
  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'email': email,
        'phone': phone,
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
      );

  /// کپی با تغییرات
  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
  }) =>
      UserProfile(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
