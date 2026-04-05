import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  // Default values
  static const String _themeKey = 'theme_mode'; // light, dark, auto
  static const String _fontSizeKey = 'font_size'; // 12, 14, 16, 18, 20
  static const String _syntaxThemeKey = 'syntax_theme'; // atom, github, monokai
  static const String _keyboardShortcutsKey = 'keyboard_shortcuts'; // true/false
  static const String _autoFormatKey = 'auto_format'; // true/false
  static const String _offlineKey = 'offline_enabled'; // true/false

  late String _themeMode;
  late double _fontSize;
  late String _syntaxTheme;
  late bool _keyboardShortcutsEnabled;
  late bool _autoFormatEnabled;
  late bool _offlineEnabled;

  SettingsProvider(this._prefs) {
    _loadSettings();
  }

  // Getters
  String get themeMode => _themeMode;
  double get fontSize => _fontSize;
  String get syntaxTheme => _syntaxTheme;
  bool get keyboardShortcutsEnabled => _keyboardShortcutsEnabled;
  bool get autoFormatEnabled => _autoFormatEnabled;
  bool get offlineEnabled => _offlineEnabled;

  void _loadSettings() {
    _themeMode = _prefs.getString(_themeKey) ?? 'dark';
    _fontSize = _prefs.getDouble(_fontSizeKey) ?? 14.0;
    _syntaxTheme = _prefs.getString(_syntaxThemeKey) ?? 'atom';
    _keyboardShortcutsEnabled = _prefs.getBool(_keyboardShortcutsKey) ?? true;
    _autoFormatEnabled = _prefs.getBool(_autoFormatKey) ?? true;
    _offlineEnabled = _prefs.getBool(_offlineKey) ?? true;
  }

  Future<void> setThemeMode(String mode) async {
    _themeMode = mode;
    await _prefs.setString(_themeKey, mode);
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _prefs.setDouble(_fontSizeKey, size);
    notifyListeners();
  }

  Future<void> setSyntaxTheme(String theme) async {
    _syntaxTheme = theme;
    await _prefs.setString(_syntaxThemeKey, theme);
    notifyListeners();
  }

  Future<void> setKeyboardShortcuts(bool enabled) async {
    _keyboardShortcutsEnabled = enabled;
    await _prefs.setBool(_keyboardShortcutsKey, enabled);
    notifyListeners();
  }

  Future<void> setAutoFormat(bool enabled) async {
    _autoFormatEnabled = enabled;
    await _prefs.setBool(_autoFormatKey, enabled);
    notifyListeners();
  }

  Future<void> setOfflineMode(bool enabled) async {
    _offlineEnabled = enabled;
    await _prefs.setBool(_offlineKey, enabled);
    notifyListeners();
  }
}
