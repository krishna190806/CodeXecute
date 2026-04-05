import 'package:flutter/material.dart';

class SyntaxHighlighter extends StatelessWidget {
  final String code;
  final String language;

  const SyntaxHighlighter({
    required this.code,
    required this.language,
    Key? key,
  }) : super(key: key);

  Map<String, Color> _getKeywordColors(String language) {
    switch (language) {
      case 'Python':
        return {
          'keyword': const Color(0xFF569CD6), // Blue
          'string': const Color(0xFFCE9178), // Orange
          'number': const Color(0xFFB5CEA8), // Green
          'comment': const Color(0xFF6A9955), // Dark Green
          'function': const Color(0xFFDCDCDC), // White
        };
      case 'Java':
        return {
          'keyword': const Color(0xFFC586C0), // Purple
          'string': const Color(0xFFCE9178), // Orange
          'number': const Color(0xFFB5CEA8), // Green
          'comment': const Color(0xFF608B4E), // Dark Green
          'function': const Color(0xFF4EC9B0), // Cyan
        };
      case 'C++':
        return {
          'keyword': const Color(0xFF569CD6), // Blue
          'string': const Color(0xFFCE9178), // Orange
          'number': const Color(0xFFB5CEA8), // Green
          'comment': const Color(0xFF7FB347), // Green
          'function': const Color(0xFFDCDCDC), // White
        };
      default:
        return {
          'keyword': const Color(0xFF569CD6),
          'string': const Color(0xFFCE9178),
          'number': const Color(0xFFB5CEA8),
          'comment': const Color(0xFF6A9955),
          'function': const Color(0xFFDCDCDC),
        };
    }
  }

  List<TextSpan> _highlightCode(String code, String language) {
    final spans = <TextSpan>[];
    final colors = _getKeywordColors(language);
    
    final pythonKeywords = [
      'def', 'class', 'if', 'else', 'elif', 'for', 'while', 'return',
      'import', 'from', 'as', 'try', 'except', 'finally', 'with', 'print',
      'lambda', 'yield', 'pass', 'break', 'continue', 'True', 'False', 'None'
    ];
    
    final javaKeywords = [
      'public', 'private', 'protected', 'static', 'class', 'interface',
      'extends', 'implements', 'void', 'int', 'String', 'boolean', 'double',
      'if', 'else', 'for', 'while', 'return', 'import', 'package', 'new',
      'try', 'catch', 'finally', 'throw', 'throws', 'true', 'false', 'null'
    ];
    
    final cppKeywords = [
      'int', 'void', 'char', 'float', 'double', 'bool', 'string', 'class',
      'struct', 'if', 'else', 'for', 'while', 'return', 'include', 'using',
      'namespace', 'public', 'private', 'protected', 'const', 'static',
      'true', 'false', 'nullptr', 'auto', 'template'
    ];

    List<String> keywords = [];
    if (language == 'Python') keywords = pythonKeywords;
    else if (language == 'Java') keywords = javaKeywords;
    else if (language == 'C++') keywords = cppKeywords;

    int i = 0;
    while (i < code.length) {
      // Handle comments
      if (i < code.length - 1 && code[i] == '/' && code[i + 1] == '/') {
        int end = code.indexOf('\n', i);
        if (end == -1) end = code.length;
        spans.add(TextSpan(
          text: code.substring(i, end),
          style: TextStyle(color: colors['comment']),
        ));
        i = end;
        continue;
      }

      // Handle strings
      if (code[i] == '"' || code[i] == "'") {
        final quote = code[i];
        int end = i + 1;
        while (end < code.length && code[end] != quote) {
          if (code[end] == '\\') end++;
          end++;
        }
        if (end < code.length) end++;
        spans.add(TextSpan(
          text: code.substring(i, end),
          style: TextStyle(color: colors['string']),
        ));
        i = end;
        continue;
      }

      // Handle numbers
      if (code[i].contains(RegExp(r'[0-9]'))) {
        int end = i;
        while (end < code.length && code[end].contains(RegExp(r'[0-9.]'))) {
          end++;
        }
        spans.add(TextSpan(
          text: code.substring(i, end),
          style: TextStyle(color: colors['number']),
        ));
        i = end;
        continue;
      }

      // Handle keywords and identifiers
      if (code[i].contains(RegExp(r'[a-zA-Z_]'))) {
        int end = i;
        while (end < code.length && 
               code[end].contains(RegExp(r'[a-zA-Z0-9_]'))) {
          end++;
        }
        final word = code.substring(i, end);
        final isKeyword = keywords.contains(word);
        
        spans.add(TextSpan(
          text: word,
          style: TextStyle(
            color: isKeyword ? colors['keyword'] : Colors.white,
            fontWeight: isKeyword ? FontWeight.w600 : FontWeight.normal,
          ),
        ));
        i = end;
        continue;
      }

      // Handle regular characters
      spans.add(TextSpan(
        text: code[i],
        style: const TextStyle(color: Colors.white70),
      ));
      i++;
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _highlightCode(code, language),
        style: const TextStyle(
          fontFamily: 'Courier',
          fontSize: 12,
          height: 1.6,
        ),
      ),
    );
  }
}
