import 'package:flutter/material.dart';
import '../widgets/language_info_card.dart';

class LanguageInfoScreen extends StatefulWidget {
  const LanguageInfoScreen({super.key});

  @override
  State<LanguageInfoScreen> createState() => _LanguageInfoScreenState();
}

class _LanguageInfoScreenState extends State<LanguageInfoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Language Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[700]!, Colors.blue[500]!],
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: '🐍 Python'),
            Tab(text: '☕ Java'),
            Tab(text: '⚙️ C++'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[900]!, Colors.grey[850]!],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildLanguageTab('Python'),
            _buildLanguageTab('Java'),
            _buildLanguageTab('C++'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTab(String language) {
    final tips = _getTipsForLanguage(language);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LanguageInfoCard(language: language),
          const SizedBox(height: 24),
          Text(
            '💡 Quick Tips',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...tips.map((tip) => _buildTipCard(tip['icon']!, tip['title']!, tip['description']!)),
          const SizedBox(height: 24),
          _buildCommonErrors(language),
          const SizedBox(height: 24),
          _buildBestPractices(language),
        ],
      ),
    );
  }

  Widget _buildTipCard(String icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$icon $title',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonErrors(String language) {
    final errors = _getCommonErrors(language);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🚨 Common Errors',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...errors.map((error) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red[900]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red[700]?.withOpacity(0.3) ?? Colors.red),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error['error']!,
                style: const TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Fix: ${error['fix']!}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildBestPractices(String language) {
    final practices = _getBestPractices(language);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '⭐ Best Practices',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...practices.map((practice) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green[900]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green[700]?.withOpacity(0.3) ?? Colors.green),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '✓',
                style: TextStyle(color: Colors.greenAccent, fontSize: 14),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  practice,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  List<Map<String, String>> _getTipsForLanguage(String language) {
    final tips = {
      'Python': [
        {
          'icon': '📌',
          'title': 'Indentation Matters',
          'description': 'Python uses indentation to define code blocks. Use spaces or tabs consistently (preferably 4 spaces).',
        },
        {
          'icon': '🔄',
          'title': 'List Comprehensions',
          'description': 'Use list comprehensions for concise and readable list operations: [x*2 for x in range(10)]',
        },
        {
          'icon': '🎁',
          'title': 'Libraries',
          'description': 'Python has a vast standard library. Import modules using: import module or from module import function',
        },
      ],
      'Java': [
        {
          'icon': '🏗️',
          'title': 'Class Structure',
          'description': 'All code must be in a class. Public class name must match the filename. Use main() method as entry point.',
        },
        {
          'icon': '📦',
          'title': 'Packages',
          'description': 'Organize code using packages. Declare at top: package com.example;',
        },
        {
          'icon': '🔐',
          'title': 'Access Modifiers',
          'description': 'Use public, private, protected to control visibility. Instance variables should typically be private.',
        },
      ],
      'C++': [
        {
          'icon': '⚡',
          'title': 'Efficiency',
          'description': 'C++ is fast due to direct memory access and compilation. Ideal for performance-critical applications.',
        },
        {
          'icon': '📚',
          'title': 'STL Library',
          'description': 'Use Standard Template Library for vectors, maps, sets, etc. Example: vector<int> v; v.push_back(5);',
        },
        {
          'icon': '🧹',
          'title': 'Memory Management',
          'description': 'Be careful with pointers and dynamic memory. Use new/delete carefully or prefer stack allocation.',
        },
      ],
    };
    return tips[language] ?? [];
  }

  List<Map<String, String>> _getCommonErrors(String language) {
    final errors = {
      'Python': [
        {
          'error': 'IndentationError',
          'fix': 'Check indentation is consistent. Mix of tabs and spaces will cause this.',
        },
        {
          'error': 'NameError: name is not defined',
          'fix': 'Variable not declared or misspelled. Ensure variable is defined before use.',
        },
        {
          'error': 'TypeError: unsupported operand type',
          'fix': 'Attempting operation on incompatible types. Convert types appropriately.',
        },
      ],
      'Java': [
        {
          'error': 'class Main is public, should be declared in a file',
          'fix': 'File name must match public class name. Rename file or class accordingly.',
        },
        {
          'error': 'Exception in thread "main": NoSuchMethodError',
          'fix': 'Method is not found or protected. Check method name and access modifiers.',
        },
        {
          'error': 'NullPointerException',
          'fix': 'Attempting to call method on null object. Initialize object before using.',
        },
      ],
      'C++': [
        {
          'error': 'Undefined reference to main',
          'fix': 'Missing main() function or incorrect syntax. Ensure: int main() { }',
        },
        {
          'error': 'Segmentation fault',
          'fix': 'Accessing invalid memory (null pointer, out of bounds). Check pointer validity.',
        },
        {
          'error': 'No match for operator',
          'fix': 'Type mismatch in operation. Ensure types are compatible or use casting.',
        },
      ],
    };
    return errors[language] ?? [];
  }

  List<String> _getBestPractices(String language) {
    final practices = {
      'Python': [
        'Use meaningful variable names and follow snake_case naming convention',
        'Add docstrings to functions and classes for documentation',
        'Use type hints for better code clarity: def add(a: int, b: int) -> int:',
        'Avoid global variables; use parameters to pass data',
        'Test your code frequently with different inputs',
      ],
      'Java': [
        'Follow camelCase naming convention for variables and methods',
        'Use meaningful class names and follow PascalCase convention',
        'Initialize variables before using them',
        'Use appropriate access modifiers (public, private, protected)',
        'Document your code with JavaDoc comments: /** ... */',
      ],
      'C++': [
        'Use const for variables that should not change',
        'Prefer references over pointers when possible: void func(int& x)',
        'Use meaningful variable and function names',
        'Always include appropriate headers (#include)',
        'Test with different edge cases and large inputs',
      ],
    };
    return practices[language] ?? [];
  }
}
