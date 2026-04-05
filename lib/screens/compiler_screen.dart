import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../services/compiler_service.dart';
import '../services/compiler_utils.dart';
import '../providers/code_snippets_provider.dart';
import '../providers/history_provider.dart';
import '../providers/snippet_provider.dart';
import '../models/code_snippet.dart';
import '../screens/snippets_list_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_detail_screen.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({super.key});

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen> with TickerProviderStateMixin {
  final CompilerService _compilerService = CompilerService();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _stdinController = TextEditingController();
  
  String _selectedLanguage = 'Python';
  String _output = '';
  bool _isLoading = false;
  bool _isErrorOutput = false;
  int _executionTime = 0;


  final List<String> _languages = ['Python', 'Java', 'C++'];
  
  // Code templates for each language
  final Map<String, String> _codeTemplates = {
    'Python': '''# Python Template
def main():
    print("Hello, World!")
    name = input("Enter your name: ")
    print(f"Hello, {name}!")

if __name__ == "__main__":
    main()
''',
    'Java': '''public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        String name = "CodeXecute";
        System.out.println("Welcome, " + name);
    }
}
''',
    'C++': '''#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    string name = "CodeXecute";
    cout << "Welcome, " << name << endl;
    return 0;
}
'''
  };

  Future<void> _runCode() async {
    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write some code first!')),
      );
      return;
    }

    final stopwatch = Stopwatch()..start();

    setState(() {
      _isLoading = true;
      _output = 'Running...';
      _isErrorOutput = false;
    });

    final result = await _compilerService.executeCode(
      _selectedLanguage,
      _codeController.text,
      stdinData: _stdinController.text,
    );

    stopwatch.stop();
    
    final executionTime = stopwatch.elapsedMilliseconds;
    final output = (result['output'] ?? '').toString().trim();
    final isError = !(result['success'] ?? false);

    // Track execution in history
    if (mounted) {
      final historyProvider = context.read<HistoryProvider>();
      historyProvider.addExecution(
        _codeController.text,
        _selectedLanguage,
        output.isEmpty ? '(No output)' : output,
        executionTime,
        !isError,
        errorMessage: isError ? output : null,
        stdinData: _stdinController.text.isNotEmpty ? _stdinController.text : null,
      );
    }

    setState(() {
      _isLoading = false;
      _executionTime = executionTime;
      // Ensure output is properly formatted
      _output = output.isEmpty ? '(No output)' : output;
      _isErrorOutput = isError;
    });
  }

  void _insertTemplate() {
    _showSnippetsDialog();
  }

  void _showSnippetsDialog() {
    final snippets = CodeSnippets.getSnippets(_selectedLanguage);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$_selectedLanguage Code Snippets',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: snippets.length,
                itemBuilder: (context, index) {
                  final snippetName = snippets.keys.toList()[index];
                  final snippetCode = snippets[snippetName]!;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _codeController.text = snippetCode;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('✅ "$snippetName" snippet inserted'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green[700],
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D0D0F),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[700]!.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snippetName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snippetCode.split('\n').first,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontFamily: 'Courier',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearCode() {
    _codeController.clear();
    _stdinController.clear();
    setState(() {
      _output = '';
    });
  }

  void _formatCode() {
    final formatted = CompilerUtils.formatCode(
      _codeController.text,
      _selectedLanguage,
    );
    _codeController.text = formatted;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code formatted!'),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _saveSnippet() {
    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write some code first!')),
      );
      return;
    }

    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E24),
        title: const Text('Save Snippet'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Snippet name (e.g., My Python Script)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                // Create and save snippet
                final snippet = CodeSnippet(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: controller.text,
                  description: 'Snippet for ${_selectedLanguage}',
                  language: _selectedLanguage,
                  code: _codeController.text,
                  isFavorite: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  tags: _selectedLanguage,
                  usageCount: 0,
                );
                
                // Save using provider
                final snippetProvider = context.read<SnippetProvider>();
                snippetProvider.saveSnippet(snippet);
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Snippet "${controller.text}" saved!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _copyCode() {
    if (_codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No code to copy!')),
      );
      return;
    }
    // Actually copy to clipboard
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard!'),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _stdinController.dispose();
    super.dispose();
  }

  Color _getLanguageColor() {
    switch (_selectedLanguage) {
      case 'Python':
        return const Color(0xFF3776AB);
      case 'Java':
        return const Color(0xFFEA2D2E);
      case 'C++':
        return const Color(0xFF00599C);
      default:
        return Colors.purple;
    }
  }

  Color _getLanguageAccent() {
    switch (_selectedLanguage) {
      case 'Python':
        return const Color(0xFFFFD43B);
      case 'Java':
        return const Color(0xFFF89820);
      case 'C++':
        return const Color(0xFF0199FF);
      default:
        return Colors.purpleAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Code Executor',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getLanguageColor().withOpacity(0.8),
                _getLanguageAccent().withOpacity(0.6),
              ],
            ),
          ),
        ),
        actions: [
          // New Features: Snippets, History, Settings
          Tooltip(
            message: 'My Snippets',
            child: IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SnippetsListScreen()),
              ),
            ),
          ),
          Tooltip(
            message: 'Execution History',
            child: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              ),
            ),
          ),
          Tooltip(
            message: 'Settings & Preferences',
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsDetailScreen()),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: 'Learn about languages',
            child: IconButton(
              icon: const Icon(Icons.school),
              onPressed: () {
                Navigator.pushNamed(context, '/language_info');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    dropdownColor: _getLanguageColor(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          _selectedLanguage = newValue;
                          _output = '';
                        }
                      });
                    },
                    items: _languages.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(_getLanguageIcon(value), color: Colors.white, size: 16),
                            const SizedBox(width: 8),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[850]!,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code Editor Section
                  _buildSectionHeader('Code Editor', _selectedLanguage),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _getLanguageAccent().withOpacity(0.3), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: _getLanguageColor().withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _codeController,
                      maxLines: 15,
                      minLines: 12,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.6,
                      ),
                      cursorColor: _getLanguageAccent(),
                      decoration: InputDecoration(
                        hintText: 'Write your $_selectedLanguage code here...',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Courier',
                          fontSize: 13,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Quick Actions - Enhanced with new features
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.description,
                          label: 'Template',
                          onPressed: _insertTemplate,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.format_indent_increase,
                          label: 'Format',
                          onPressed: _formatCode,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.clear,
                          label: 'Clear',
                          onPressed: _clearCode,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Save and Copy buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.save,
                          label: 'Save Snippet',
                          onPressed: _saveSnippet,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.content_copy,
                          label: 'Copy Code',
                          onPressed: _copyCode,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Input Section
                  _buildSectionHeader('Input', 'stdin'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue[300]!.withOpacity(0.4),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _stdinController,
                          maxLines: 3,
                          minLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Courier',
                            height: 1.5,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText: 'Enter input data here\n(For multiple inputs, press Enter for each line)',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              height: 1.4,
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            border: InputBorder.none,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, size: 14, color: Colors.blue[300]),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Input will be passed to your code via stdin',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue[300],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Output Section
                  _buildSectionHeader('Output', _isErrorOutput ? 'Error' : 'Success'),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 120, maxHeight: 350),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isErrorOutput ? Colors.redAccent.withOpacity(0.6) : Colors.greenAccent.withOpacity(0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isErrorOutput ? Colors.red : Colors.green).withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              _output.isEmpty 
                                ? '(No output)' 
                                : _output,
                              style: TextStyle(
                                fontFamily: 'Courier New',
                                color: _isErrorOutput 
                                  ? Colors.redAccent 
                                  : Colors.greenAccent,
                                fontSize: 13,
                                height: 1.8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _runCode,
        backgroundColor: _getLanguageColor(),
        icon: _isLoading 
          ? const SizedBox(
              width: 20, 
              height: 20, 
              child: CircularProgressIndicator(
                color: Colors.white, 
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.play_arrow, size: 26),
        label: Text(
          _isLoading ? 'Compiling...' : 'Run Code',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: 40,
          decoration: BoxDecoration(
            color: _getLanguageAccent(),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(0.15),
            border: Border.all(color: color.withOpacity(0.4), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLanguageIcon(String language) {
    switch (language) {
      case 'Python':
        return Icons.circle;
      case 'Java':
        return Icons.coffee;
      case 'C++':
        return Icons.add;
      default:
        return Icons.code;
    }
  }

}
