import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves and restores the chosen theme with SharedPreferencesAsync.
class ThemeStore {
  ThemeStore._();

  static const _key = 'theme_mode';
  static final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  static Future<ThemeMode> load() async {
    final value = await _prefs.getString(_key);
    return value == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> save(ThemeMode mode) =>
      _prefs.setString(_key, mode == ThemeMode.dark ? 'dark' : 'light');
}
