import 'dart:convert';

class MealSlot {
  const MealSlot({required this.mealType, this.recipeId, this.recipeName});
  final String mealType;
  final String? recipeId;
  final String? recipeName;

  factory MealSlot.fromJson(Map<String, dynamic> json) => MealSlot(
        mealType: json['mealType'] as String,
        recipeId: json['recipeId'] as String?,
        recipeName: json['recipeName'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'mealType': mealType,
        'recipeId': recipeId,
        'recipeName': recipeName,
      };
}

class DayPlan {
  const DayPlan({required this.date, required this.slots});
  final DateTime date;
  final List<MealSlot> slots;

  String get dayName {
    const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    return days[date.weekday - 1];
  }

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  factory DayPlan.fromJson(Map<String, dynamic> json) => DayPlan(
        date: DateTime.parse(json['date'] as String),
        slots: (json['slots'] as List<dynamic>)
            .map((s) => MealSlot.fromJson(s as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'slots': slots.map((s) => s.toJson()).toList(),
      };
}

class MealPlan {
  const MealPlan({required this.days, required this.generatedAt});
  final List<DayPlan> days;
  final DateTime generatedAt;

  bool get isExpired =>
      DateTime.now().difference(generatedAt).inDays >= 7;

  DayPlan? get today {
    try {
      return days.firstWhere((d) => d.isToday);
    } catch (_) {
      return null;
    }
  }

  String toJsonString() => jsonEncode({
        'days': days.map((d) => d.toJson()).toList(),
        'generatedAt': generatedAt.toIso8601String(),
      });

  factory MealPlan.fromJsonString(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return MealPlan(
      generatedAt: DateTime.parse(map['generatedAt'] as String),
      days: (map['days'] as List<dynamic>)
          .map((d) => DayPlan.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
