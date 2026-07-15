import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/auth_storage.dart';

// ── Storage keys ──────────────────────────────────────────────────────────
const _keyTheme         = 'reena.settings.theme.v1';
const _keyMealReminder  = 'reena.settings.meal_reminder.v1';
const _keyShopReminder  = 'reena.settings.shop_reminder.v1';
const _keyHealthGoals   = 'reena.settings.health_goals.v1';
const _keyDietaryNotes  = 'reena.settings.dietary.v1';
const _keyFamilyName    = 'reena.settings.family_name.v1';

// ── Theme ─────────────────────────────────────────────────────────────────
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._prefs)
      : super(_fromString(_prefs.getString(_keyTheme)));

  final SharedPreferences _prefs;

  static ThemeMode _fromString(String? v) {
    switch (v) {
      case 'light': return ThemeMode.light;
      case 'dark':  return ThemeMode.dark;
      default:      return ThemeMode.system;
    }
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(_keyTheme, mode.name);
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.read(sharedPreferencesProvider));
});

// ── Notification preferences ─────────────────────────────────────────────
class NotificationSettings {
  const NotificationSettings({
    this.mealReminder = true,
    this.shopReminder = true,
  });
  final bool mealReminder;
  final bool shopReminder;
}

class NotificationNotifier extends StateNotifier<NotificationSettings> {
  NotificationNotifier(this._prefs)
      : super(NotificationSettings(
          mealReminder: _prefs.getBool(_keyMealReminder) ?? true,
          shopReminder: _prefs.getBool(_keyShopReminder) ?? true,
        ));

  final SharedPreferences _prefs;

  Future<void> setMealReminder(bool v) async {
    state = NotificationSettings(mealReminder: v, shopReminder: state.shopReminder);
    await _prefs.setBool(_keyMealReminder, v);
  }

  Future<void> setShopReminder(bool v) async {
    state = NotificationSettings(mealReminder: state.mealReminder, shopReminder: v);
    await _prefs.setBool(_keyShopReminder, v);
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationSettings>((ref) {
  return NotificationNotifier(ref.read(sharedPreferencesProvider));
});

// ── Health goals ──────────────────────────────────────────────────────────
const availableHealthGoals = [
  'Weight management',
  'More protein',
  'High fibre',
  'Low calorie',
  'Diabetes management',
  'Heart health',
  'Bone health',
  'Energy boost',
];

class HealthGoalsNotifier extends StateNotifier<List<String>> {
  HealthGoalsNotifier(this._prefs)
      : super(_prefs.getStringList(_keyHealthGoals) ?? []);

  final SharedPreferences _prefs;

  Future<void> toggle(String goal) async {
    final updated = List<String>.from(state);
    if (updated.contains(goal)) {
      updated.remove(goal);
    } else {
      updated.add(goal);
    }
    state = updated;
    await _prefs.setStringList(_keyHealthGoals, updated);
  }
}

final healthGoalsProvider =
    StateNotifierProvider<HealthGoalsNotifier, List<String>>((ref) {
  return HealthGoalsNotifier(ref.read(sharedPreferencesProvider));
});

// ── Family name ──────────────────────────────────────────────────────────
final familyNameProvider = Provider<String>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return prefs.getString(_keyFamilyName) ?? '';
});

// ── Dietary notes ─────────────────────────────────────────────────────────
final dietaryNotesProvider = Provider<String>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return prefs.getString(_keyDietaryNotes) ?? '';
});
