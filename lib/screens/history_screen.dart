import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/history_provider.dart';
import '../models/code_execution.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedLanguageFilter = 'all';

  @override
  void initState() {
    super.initState();
    // Load history when screen opens
    Future.microtask(() => context.read<HistoryProvider>().loadHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Execution History'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _showClearHistoryDialog(context),
            tooltip: 'Clear history',
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, _) {
          return Column(
            children: [
              // Language Filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: [
                      _buildFilterChip('all', 'All'),
                      _buildFilterChip('python', 'Python'),
                      _buildFilterChip('java', 'Java'),
                      _buildFilterChip('cpp', 'C++'),
                    ],
                  ),
                ),
              ),

              // History List
              Expanded(
                child: _buildHistoryList(context, historyProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String language, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: _selectedLanguageFilter == language,
        onSelected: (selected) {
          setState(() => _selectedLanguageFilter = language);
        },
      ),
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    HistoryProvider historyProvider,
  ) {
    var executions = _selectedLanguageFilter == 'all'
        ? historyProvider.executions
        : historyProvider.filterByLanguage(
            _selectedLanguageFilter.toUpperCase());

    if (executions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No execution history',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: executions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final execution = executions[index];
        return _buildExecutionCard(context, execution);
      },
    );
  }

  Widget _buildExecutionCard(BuildContext context, CodeExecution execution) {
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm:ss');
    final isSuccess = execution.isSuccess;

    return Card(
      child: InkWell(
        onTap: () => _showExecutionDetail(context, execution),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSuccess
                  ? [Colors.green[900]!, Colors.green[800]!]
                  : [Colors.red[900]!, Colors.red[800]!],
            ),
            border: Border.all(
              color: (isSuccess ? Colors.green : Colors.red).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isSuccess ? Colors.green : Colors.red)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      execution.language,
                      style: TextStyle(
                        color: isSuccess ? Colors.greenAccent : Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    color: isSuccess
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Timestamp and execution time
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 6),
                  Text(
                    dateFormat.format(execution.executedAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                  const Spacer(),
                  Text(
                    '${execution.executionTimeMs}ms',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Code Preview
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  execution.code.split('\n').first,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Courier',
                    color: Colors.greenAccent,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),

              // Output Preview
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  execution.output.split('\n').first,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Courier',
                    color: Colors.grey[400],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExecutionDetail(BuildContext context, CodeExecution execution) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        Text(
                          '${execution.language} - '
                          '${execution.executionTimeMs}ms',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          execution.isSuccess
                              ? Icons.check_circle
                              : Icons.error,
                          color: execution.isSuccess
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Code:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Text(
                        execution.code,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Courier New',
                          color: Colors.greenAccent,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Output:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Text(
                        execution.output.isEmpty
                            ? '(No output)'
                            : execution.output,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Courier New',
                          color: execution.isSuccess
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text(
          'Are you sure you want to clear all execution history? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<HistoryProvider>().clearHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
