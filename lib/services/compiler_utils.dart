/// Error explanation and code formatting utilities
class CompilerUtils {
  // Explain common compiler/runtime errors
  static String explainError(String errorMessage, String language) {
    final error = errorMessage.toLowerCase();

    // Python errors
    if (language == 'Python') {
      if (error.contains('syntaxerror')) {
        return 'Syntax Error: Check your code for typos, missing colons, incorrect indentation, or unclosed brackets/parentheses.';
      }
      if (error.contains('nameerror')) {
        return 'Name Error: You\'re using a variable or function that hasn\'t been defined. Check spelling and make sure it\'s declared before use.';
      }
      if (error.contains('typeerror')) {
        return 'Type Error: You\'re trying to perform an operation on incompatible data types (e.g., adding a string to a number).';
      }
      if (error.contains('indexerror')) {
        return 'Index Error: You\'re trying to access an index that doesn\'t exist in a list or string.';
      }
      if (error.contains('keyerror')) {
        return 'Key Error: You\'re trying to access a dictionary key that doesn\'t exist.';
      }
      if (error.contains('zerodivisionerror')) {
        return 'Zero Division Error: You\'re trying to divide by zero. Check your divider value.';
      }
      if (error.contains('indentationerror')) {
        return 'Indentation Error: Python relies on proper indentation. Check your spaces/tabs alignment.';
      }
    }

    // Java errors
    if (language == 'Java') {
      if (error.contains('error:')) {
        return 'Compilation Error: Check for syntax errors, missing semicolons, unmatched braces, or incorrect class/method declarations.';
      }
      if (error.contains('nullpointerexception') || error.contains('npe')) {
        return 'Null Pointer Exception: You\'re trying to access a variable that is null. Initialize it before using it.';
      }
      if (error.contains('arrayindexoutofboundsexception')) {
        return 'Array Index Out of Bounds: The index you\'re accessing doesn\'t exist in the array. Array indices start at 0.';
      }
      if (error.contains('classnotfoundexception')) {
        return 'Class Not Found Exception: The referenced class doesn\'t exist or isn\'t in the classpath.';
      }
      if (error.contains('numberformatexception')) {
        return 'Number Format Exception: You\'re trying to convert a non-numeric string to a number.';
      }
    }

    // C++ errors
    if (language == 'C++') {
      if (error.contains('error:') || error.contains('undefined reference')) {
        return 'Compilation Error: Check for unmatched braces, missing semicolons, or undefined variables/functions.';
      }
      if (error.contains('segmentation fault') || error.contains('sigsegv')) {
        return 'Segmentation Fault: You\'re accessing memory that your program doesn\'t own. Check array bounds and pointer usage.';
      }
      if (error.contains('no such file')) {
        return 'File Error: The file you\'re trying to access doesn\'t exist. Check the file path and name.';
      }
      if (error.contains('out of memory')) {
        return 'Out of Memory: Your program is using too much memory. Check for memory leaks or reduce data size.';
      }
    }

    return 'Try checking the error message above for clues. Common issues: syntax errors, missing variable declarations, wrong data types, or incorrect function calls.';
  }

  // Format Python code (simple formatter)
  static String formatPython(String code) {
    // This is a basic formatter. For production, use dart_style or similar
    var lines = code.split('\n');
    var formatted = <String>[];

    for (var line in lines) {
      // Remove trailing whitespace
      var trimmed = line.trimRight();
      formatted.add(trimmed);
    }

    return formatted.join('\n').trim();
  }

  // Format Java code (simple formatter)
  static String formatJava(String code) {
    var lines = code.split('\n');
    var formatted = <String>[];
    var indentLevel = 0;
    const String indent = '    ';

    for (var line in lines) {
      var trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      // Decrease indent for closing braces
      if (trimmed.startsWith('}')) {
        indentLevel = (indentLevel - 1).clamp(0, 100);
      }

      // Add proper indentation
      formatted.add('${'$indent' * indentLevel}$trimmed');

      // Increase indent for opening braces
      if (trimmed.endsWith('{')) {
        indentLevel++;
      }
    }

    return formatted.join('\n').trim();
  }

  // Format C++ code (simple formatter)
  static String formatCpp(String code) {
    var lines = code.split('\n');
    var formatted = <String>[];
    var indentLevel = 0;
    const String indent = '    ';

    for (var line in lines) {
      var trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      // Decrease indent for closing braces
      if (trimmed.startsWith('}')) {
        indentLevel = (indentLevel - 1).clamp(0, 100);
      }

      // Add proper indentation
      formatted.add('${'$indent' * indentLevel}$trimmed');

      // Increase indent for opening braces
      if (trimmed.endsWith('{')) {
        indentLevel++;
      }
    }

    return formatted.join('\n').trim();
  }

  static String formatCode(String code, String language) {
    switch (language.toLowerCase()) {
      case 'python':
        return formatPython(code);
      case 'java':
        return formatJava(code);
      case 'c++':
        return formatCpp(code);
      default:
        return code;
    }
  }

  // Get language icon
  static String getLanguageEmoji(String language) {
    switch (language.toLowerCase()) {
      case 'python':
        return '🐍';
      case 'java':
        return '☕';
      case 'c++':
        return '⚙️';
      default:
        return '💻';
    }
  }
}
