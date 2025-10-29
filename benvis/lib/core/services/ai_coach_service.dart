import 'dart:math';

/// سرویس AI Coach (Mock آفلاین)
/// در فاز اول با قوانین ساده کار می‌کند
class AiCoachService {
  final _random = Random();

  /// تحلیل متن ژورنال و استخراج بینش
  String analyzeJournal(String content) {
    final lowerContent = content.toLowerCase();

    // کلمات کلیدی مثبت
    if (lowerContent.contains('خوشحال') ||
        lowerContent.contains('عالی') ||
        lowerContent.contains('موفق')) {
      return '🎉 روز پرانرژی! ادامه بده، داری خیلی خوب پیش می‌ری.';
    }

    // کلمات کلیدی منفی
    if (lowerContent.contains('خسته') ||
        lowerContent.contains('ناامید') ||
        lowerContent.contains('سخت')) {
      return '💪 روزهای سخت هم می‌گذرند. یک قدم کوچک برای فردا کافیه.';
    }

    // کلمات مرتبط با یادگیری
    if (lowerContent.contains('یاد گرفتم') ||
        lowerContent.contains('مطالعه') ||
        lowerContent.contains('کتاب')) {
      return '📚 یادگیری هر روز یک قدم به جلو است. عالی!';
    }

    // ورزش
    if (lowerContent.contains('ورزش') ||
        lowerContent.contains('تمرین') ||
        lowerContent.contains('دویدن')) {
      return '🏃‍♂️ حرکت یعنی زندگی! ادامه بده.';
    }

    // پیش‌فرض
    return '✨ امروز هم یک روز خاص بود. به جلو نگاه کن!';
  }

  /// پیشنهاد هدف بعدی بر اساس عادات
  String suggestNextGoal(List<String> completedHabits) {
    if (completedHabits.isEmpty) {
      return 'شروع با یک عادت کوچک می‌تونه روزت رو متحول کنه!';
    }

    if (completedHabits.length >= 3) {
      return 'وااو! امروز سه عادت رو تکمیل کردی. یک هدف بزرگ‌تر تعیین کن!';
    }

    return 'خوب پیش می‌ری! یک عادت دیگه اضافه کن؟';
  }

  /// نقل قول روزانه الهام‌بخش
  String getDailyQuote() {
    final quotes = [
      '💡 "تنها راه انجام کار عالی، عشق به کاری است که انجام می‌دهی."',
      '🌟 "موفقیت مجموع تلاش‌های کوچک روزانه است."',
      '🚀 "شروع کن، حتی اگر کامل نباشی."',
      '⚡ "امروز می‌تواند بهترین روز زندگیت باشد."',
      '🌱 "هر روز فرصتی برای رشد است."',
      '🎯 "تمرکز بر یک هدف، قدرت بی‌نهایت می‌دهد."',
      '💪 "تو قوی‌تر از چیزی هستی که فکر می‌کنی."',
      '🌈 "بعد از هر طوفان، رنگین‌کمانی می‌آید."',
      '🔥 "پشتکار کلید هر موفقیتی است."',
      '🌸 "زندگی زیباست، حتی در لحظات سخت."',
    ];

    return quotes[_random.nextInt(quotes.length)];
  }

  /// پیام صبحگاهی
  String getMorningInsight() {
    final insights = [
      '☀️ صبح بخیر! امروز چه هدفی داری؟',
      '🌅 یک روز جدید، فرصت‌های جدید!',
      '🎯 روی اهداف امروزت تمرکز کن.',
      '💪 انرژی مثبت برات آرزو می‌کنم!',
      '✨ یک قدم کوچک امروز = یک تغییر بزرگ فردا',
    ];

    return insights[_random.nextInt(insights.length)];
  }

  /// پیام شبانه
  String getEveningInsight() {
    final insights = [
      '🌙 امروز چطور بود؟ یادداشتش کن!',
      '⭐ به دستاوردهای امروزت فکر کن.',
      '💤 استراحت خوب برای فردای بهتر!',
      '📝 چند دقیقه برای خودت بنویس.',
      '🌠 شکرگزار باش، امروز هم گذشت.',
    ];

    return insights[_random.nextInt(insights.length)];
  }

  /// تحلیل پیشرفت هفتگی
  String getWeeklySummary({
    required int goalsCompleted,
    required int habitsStreak,
    required int journalEntries,
  }) {
    var score = 0;
    if (goalsCompleted > 0) score += 3;
    if (habitsStreak >= 7) score += 4;
    if (journalEntries >= 5) score += 3;

    if (score >= 8) {
      return '🏆 هفته فوق‌العاده! تو یک قهرمان واقعی هستی!';
    } else if (score >= 5) {
      return '⭐ هفته خوبی بود! هفته بعد رو بهتر کن.';
    } else {
      return '💪 هفته بعد فرصت جدیدی برای پیشرفت است!';
    }
  }
}
