import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../models/code_execution.dart';

class HistoryProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  
  List<CodeExecution> _executions = [];
  static const String _historyKey = 'execution_history';
  static const int _maxHistoryItems = 100;

  List<CodeExecution> get executions => _executions;
  
  HistoryProvider(this._prefs) {
    _loadHistory();
  }

  void addExecution(
    String code,
    String language,
    String output,
    int executionTimeMs,
    bool isSuccess, {
    String? errorMessage,
    String? stdinData,
  }) {
    final execution = CodeExecution(
      id: const Uuid().v4(),
      code: code,
      language: language,
      output: output,
      executionTimeMs: executionTimeMs,
      isSuccess: isSuccess,
      errorMessage: errorMessage,
      stdinData: stdinData,
    );

    _executions.insert(0, execution); // Add to beginning (newest first)

    // Keep only last 100 items
    if (_executions.length > _maxHistoryItems) {
      _executions.removeRange(_maxHistoryItems, _executions.length);
    }

    _saveHistory();
    notifyListeners();
  }

  void clearHistory() {
    _executions.clear();
    _prefs.remove(_historyKey);
    notifyListeners();
  }

  List<CodeExecution> filterByLanguage(String language) {
    return _executions.where((e) => e.language == language).toList();
  }

  void loadHistory() {
    _loadHistory();
    notifyListeners();
  }

  void _loadHistory() {
    try {
      final json = _prefs.getString(_historyKey);
      if (json != null) {
        final List<dynamic> decoded = jsonDecode(json);
        _executions = decoded.map((item) => CodeExecution.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
    }
  }

  Future<void> _saveHistory() async {
    try {
      final json = jsonEncode(_executions.map((e) => e.toJson()).toList());
      await _prefs.setString(_historyKey, json);
    } catch (e) {
      debugPrint('Error saving history: $e');
    }
  }
}
