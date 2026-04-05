import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'compiler_utils.dart';

class CompilerService {


  // Map user-friendly language names to Wandbox API compiler names
  static const Map<String, String> _compilerMap = {
    'Python': 'cpython-3.14.0',
    'Java': 'openjdk-jdk-22+36',
    'C++': 'gcc-13.2.0',
  };

  // Map language names to version info
  static const Map<String, String> _languageVersions = {
    'Python': 'Latest Python 3.x',
    'Java': 'OpenJDK 22+',
    'C++': 'GCC Latest',
  };

  /// Get language version info
  static String getLanguageVersion(String language) {
    return _languageVersions[language] ?? 'Unknown';
  }

  /// Check code syntax without executing (basic validation)
  static Future<Map<String, dynamic>> validateSyntax(
    String language,
    String sourceCode,
  ) async {
    try {
      // Basic syntax checks
      if (sourceCode.isEmpty) {
        return {
          'valid': false,
          'errors': ['Code is empty'],
        };
      }

      List<String> errors = [];

      // Minimal validation - allow most code to attempt execution
      // The server will catch actual syntax errors
      
      if (language == 'Java') {
        // Just check for basic Java structure
        int openBraces = sourceCode.split('{').length - 1;
        int closeBraces = sourceCode.split('}').length - 1;
        if (openBraces > 0 && openBraces != closeBraces) {
          errors.add('Warning: Unbalanced braces in Java code');
        }
      } else if (language == 'C++') {
        // Check C++ braces
        int openBraces = sourceCode.split('{').length - 1;
        int closeBraces = sourceCode.split('}').length - 1;
        if (openBraces > 0 && openBraces != closeBraces) {
          errors.add('Warning: Unbalanced braces in C++ code');
        }
      }
      // Python: Don't validate too strictly

      return {
        'valid': true, // Allow execution, let server handle real errors
        'errors': errors,
      };
    } catch (e) {
      return {
        'valid': true, // Allow execution despite validation issues
        'errors': [],
      };
    }
  }

  /// Get code analysis
  static Future<Map<String, dynamic>> analyzeCode(
    String language,
    String sourceCode,
  ) async {
    try {
      int lineCount = sourceCode.split('\n').length;
      int characterCount = sourceCode.length;
      int functionCount = _countFunctions(sourceCode, language);
      
      return {
        'lines': lineCount,
        'characters': characterCount,
        'functions': functionCount,
        'size': _getCodeSize(characterCount),
      };
    } catch (e) {
      return {
        'lines': 0,
        'characters': 0,
        'functions': 0,
        'error': e.toString(),
      };
    }
  }

  static int _countFunctions(String code, String language) {
    int count = 0;
    if (language == 'Python') {
      count = 'def '.allMatches(code).length;
    } else if (language == 'Java') {
      // Count method definitions (simple approach)
      count = RegExp(r'(public|private|protected)?\s*(static)?\s*\w+\s+\w+\s*\([^)]*\)')
          .allMatches(code)
          .length;
    } else if (language == 'C++') {
      // Count function definitions
      count = RegExp(r'\w+\s+\w+\s*\([^)]*\)\s*\{').allMatches(code).length;
    }
    return count;
  }

  static String _getCodeSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  /// Executes code using the Wandbox API and returns the result
  Future<Map<String, dynamic>> executeCode(
    String language,
    String sourceCode, {
    String stdinData = '',
  }) async {
    final compilerName = _compilerMap[language];
    if (compilerName == null) {
      return {
        'success': false,
        'output': 'Unsupported language selected.',
      };
    }

    try {
      final String url = 'https://wandbox.org/api/compile.json';
      
      // Ensure stdin has proper formatting - add newline if data exists and doesn't end with one
      String formattedStdin = stdinData;
      if (stdinData.isNotEmpty && !stdinData.endsWith('\n')) {
        formattedStdin = '$stdinData\n';
      }
      
      String codeToExecute = sourceCode;
      if (language == 'Java') {
        // Wandbox defaults to 'prog.java'. A 'public class' must match this filename.
        // Stripping 'public' modifier prevents compilation errors elegantly.
        codeToExecute = codeToExecute.replaceAll(RegExp(r'public\s+class\s+'), 'class ');
      }

      if (kDebugMode) {
        print('📤 Sending Request to Wandbox:');
        print('  Compiler: $compilerName');
        print('  Code length: ${codeToExecute.length} chars');
        print('  Stdin provided: ${stdinData.isNotEmpty}');
        print('  Stdin data: "${stdinData.replaceAll('\n', '\\n')}"');
        print('  Formatted stdin: "${formattedStdin.replaceAll('\n', '\\n')}"');
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'compiler': compilerName,
          'code': codeToExecute,
          'stdin': formattedStdin,
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => http.Response(
          jsonEncode({
            'status': '1',
            'compiler_error': 'Request timeout - compilation took too long',
          }),
          504,
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (kDebugMode) {
          print('🔍 API Response Debug:');
          print('  Status: ${data['status']}');
          print('  Program Output: ${data['program_output']}');
          print('  Compiler Error: ${data['compiler_error']}');
          print('  Program Error: ${data['program_error']}');
        }

        final bool isSuccess = data['status'] == '0';

        // Collect all output - Programiz style (clean and simple)
        List<String> outputParts = [];
        
        // Add compiler errors if any
        String? compilerError;
        if (data['compiler_error'] != null &&
            data['compiler_error'].toString().trim().isNotEmpty) {
          compilerError = data['compiler_error'].toString().trim();
          outputParts.add('Compiler Error:\n$compilerError');
          // Add error explanation
          final explanation =
              CompilerUtils.explainError(compilerError, language);
          outputParts.add('\nDiagnosis:\n$explanation');
        }
        
        // Add program output if any
        if (data['program_output'] != null &&
            data['program_output'].toString().trim().isNotEmpty) {
          outputParts.add(data['program_output'].toString().trim());
        }
        
        // Add runtime errors if any
        String? runtimeError;
        if (data['program_error'] != null &&
            data['program_error'].toString().trim().isNotEmpty) {
          runtimeError = data['program_error'].toString().trim();
          outputParts.add('Runtime Error:\n$runtimeError');
          // Add error explanation
          final explanation = CompilerUtils.explainError(runtimeError, language);
          outputParts.add('\nDiagnosis:\n$explanation');
        }

        // Combine all output with proper spacing
        String finalOutput = outputParts.join('\n');
        
        if (finalOutput.trim().isEmpty) {
          finalOutput = '(No output)';
        } else if (isSuccess) {
          // Add success indicator like Programiz
          finalOutput = '$finalOutput\n\n=== Code Execution Successful ===';
        }

        return {
          'success': isSuccess,
          'output': finalOutput,
          'compiler': data['compiler_output'] ?? '',
        };
      } else if (response.statusCode == 504) {
        return {
          'success': false,
          'output': 'Timeout: Compilation took too long (>30s)\nTry simplifying your code.',
        };
      } else {
        return {
          'success': false,
          'output': 'Server Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'output': 'Connection Error: $e\n\nPlease check your internet connection.',
      };
    }
  }

  /// Get code examples for language
  static List<String> getLanguageFeatures(String language) {
    final features = {
      'Python': [
        '🐍 Dynamic typing',
        '📚 Rich standard library',
        '🔄 List comprehensions',
        '🎁 Decorators',
        '🔧 Exception handling',
      ],
      'Java': [
        '☕ Object-oriented',
        '🛡️ Type-safe',
        '⚡ High performance',
        '🏗️ Comprehensive libraries',
        '♻️ Garbage collection',
      ],
      'C++': [
        '⚡ Ultra-fast',
        '🎯 Low-level access',
        '🏗️ Object-oriented',
        '📦 STL containers',
        '🔧 Memory control',
      ],
    };
    return features[language] ?? [];
  }

  /// Format code based on language
  static String formatCode(String code, String language) {
    return CompilerUtils.formatCode(code, language);
  }

  /// Get language version info with emoji
  static String getLanguageWithEmoji(String language) {
    final emoji = CompilerUtils.getLanguageEmoji(language);
    return '$emoji $language';
  }
}

