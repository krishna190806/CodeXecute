import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../models/code_snippet.dart';

class SnippetProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  
  List<CodeSnippet> _snippets = [];
  bool _isLoading = false;
  String _filter = '';

  List<CodeSnippet> get snippets {
    if (_filter.isEmpty || _filter == 'all') {
      return _snippets;
    } else if (_filter == 'favorites') {
      return _snippets.where((s) => s.isFavorite).toList();
    } else {
      return _snippets.where((s) => s.language.toLowerCase() == _filter.toLowerCase()).toList();
    }
  }

  List<CodeSnippet> get favorites => _snippets.where((s) => s.isFavorite).toList();
  bool get isLoading => _isLoading;
  String get filter => _filter;

  SnippetProvider(this._prefs) {
    _loadSnippetsLocally();
  }

  // Load snippets (local only)
  Future<void> loadSnippets() async {
    _isLoading = true;
    notifyListeners();
    _loadSnippetsLocally();
    _isLoading = false;
    notifyListeners();
  }

  // Save snippet (local only)
  Future<void> saveSnippet(CodeSnippet snippet) async {
    try {
      final id = snippet.id.isEmpty ? const Uuid().v4() : snippet.id;
      final updatedSnippet = snippet.copyWith(
        id: id,
        updatedAt: DateTime.now(),
      );

      final index = _snippets.indexWhere((s) => s.id == id);
      if (index >= 0) {
        _snippets[index] = updatedSnippet;
      } else {
        _snippets.add(updatedSnippet);
      }

      await _saveSnippetsLocallyAsync(_snippets);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving snippet: $e');
    }
  }

  // Delete snippet
  Future<void> deleteSnippet(String snippetId) async {
    try {
      _snippets.removeWhere((s) => s.id == snippetId);
      await _saveSnippetsLocallyAsync(_snippets);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting snippet: $e');
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(String snippetId) async {
    final index = _snippets.indexWhere((s) => s.id == snippetId);
    if (index >= 0) {
      final snippet = _snippets[index];
      final updated = snippet.copyWith(isFavorite: !snippet.isFavorite);
      await saveSnippet(updated);
    }
  }

  // Set filter
  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  // Search snippets
  List<CodeSnippet> searchSnippets(String query) {
    if (query.isEmpty) return snippets;
    
    return snippets
        .where((s) =>
            s.title.toLowerCase().contains(query.toLowerCase()) ||
            s.description.toLowerCase().contains(query.toLowerCase()) ||
            s.code.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Load snippets from local storage
  void _loadSnippetsLocally() {
    try {
      final json = _prefs.getString('snippets');
      if (json != null) {
        final List<dynamic> decoded = jsonDecode(json);
        _snippets = decoded.map((item) => CodeSnippet.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint('Error loading local snippets: $e');
    }
    notifyListeners();
  }

  // Save snippets to local storage
  Future<void> _saveSnippetsLocallyAsync(List<CodeSnippet> snippets) async {
    try {
      final json = jsonEncode(snippets.map((s) => s.toJson()).toList());
      await _prefs.setString('snippets', json);
    } catch (e) {
      debugPrint('Error saving local snippets: $e');
    }
  }

  // Generate share link
  String generateShareLink(CodeSnippet snippet) {
    final encoded = base64Encode(utf8.encode(jsonEncode(snippet.toJson())));
    return 'https://codexecute.app/snippet/$encoded';
  }

  // Decode share link
  static CodeSnippet? decodeShareLink(String encoded) {
    try {
      final decoded = utf8.decode(base64Decode(encoded));
      final json = jsonDecode(decoded);
      return CodeSnippet.fromJson(json);
    } catch (e) {
      debugPrint('Error decoding share link: $e');
      return null;
    }
  }
}
