import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../providers/snippet_provider.dart';
import '../models/code_snippet.dart';

class SnippetsListScreen extends StatefulWidget {
  const SnippetsListScreen({super.key});

  @override
  State<SnippetsListScreen> createState() => _SnippetsListScreenState();
}

class _SnippetsListScreenState extends State<SnippetsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load snippets when screen opens
    Future.microtask(() => context.read<SnippetProvider>().loadSnippets());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Snippets'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNewSnippetDialog(context),
            tooltip: 'New Snippet',
          ),
        ],
      ),
      body: Consumer<SnippetProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search snippets...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                  ),
                ),
              ),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      _buildFilterChip('all', 'All'),
                      _buildFilterChip('favorites', 'Favorites'),
                      _buildFilterChip('python', 'Python'),
                      _buildFilterChip('java', 'Java'),
                      _buildFilterChip('cpp', 'C++'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Snippets List
              Expanded(
                child: _buildSnippetsList(context, provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: _selectedFilter == filter,
        onSelected: (selected) {
          setState(() => _selectedFilter = filter);
          final provider = context.read<SnippetProvider>();
          provider.setFilter(filter);
        },
      ),
    );
  }

  Widget _buildSnippetsList(BuildContext context, SnippetProvider provider) {
    var snippets = _searchQuery.isEmpty
        ? provider.snippets
        : provider.searchSnippets(_searchQuery);

    if (snippets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.code_off, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty ? 'No snippets found' : 'No snippets yet',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showNewSnippetDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Snippet'),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: snippets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final snippet = snippets[index];
        return _buildSnippetCard(context, snippet, provider);
      },
    );
  }

  Widget _buildSnippetCard(
    BuildContext context,
    CodeSnippet snippet,
    SnippetProvider provider,
  ) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Card(
      child: InkWell(
        onTap: () => _showSnippetDetail(context, snippet),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[800]!,
                Colors.grey[900]!,
              ],
            ),
            border: Border.all(
              color: _getLanguageColor(snippet.language).withOpacity(0.3),
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
                      color: _getLanguageColor(snippet.language).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      snippet.language,
                      style: TextStyle(
                        color: _getLanguageColor(snippet.language),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      snippet.isFavorite ? Icons.star : Icons.star_outline,
                      color: snippet.isFavorite ? Colors.amber : Colors.grey,
                      size: 20,
                    ),
                    onPressed: () => provider.toggleFavorite(snippet.id),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('Edit'),
                        onTap: () => _showEditSnippetDialog(context, snippet),
                      ),
                      PopupMenuItem(
                        child: const Text('Share'),
                        onTap: () => _showShareDialog(context, snippet, provider),
                      ),
                      PopupMenuItem(
                        child: const Text('Delete'),
                          onTap: () => provider.deleteSnippet(snippet.id),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title & Description
              Text(
                snippet.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (snippet.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  snippet.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),

              // Code Preview
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  snippet.code.split('\n').first,
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

              // Footer
              Row(
                children: [
                  Text(
                    '${dateFormat.format(snippet.createdAt)} ${timeFormat.format(snippet.createdAt)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  const Spacer(),
                  if ((snippet.usageCount ?? 0) > 0) ...[
                    Icon(Icons.play_arrow, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      '${snippet.usageCount} runs',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnippetDetail(BuildContext context, CodeSnippet snippet) {
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
                    Text(
                      snippet.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getLanguageColor(snippet.language).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        snippet.code,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Courier New',
                          color: Colors.greenAccent,
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

  void _showNewSnippetDialog(BuildContext context) {
    // Implementation for creating new snippet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New snippet dialog')),
    );
  }

  void _showEditSnippetDialog(BuildContext context, CodeSnippet snippet) {
    final titleController = TextEditingController(text: snippet.title);
    final descController = TextEditingController(text: snippet.description);
    final codeController = TextEditingController(text: snippet.code);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E24),
        title: const Text('Edit Snippet'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Code',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedSnippet = snippet.copyWith(
                title: titleController.text,
                description: descController.text,
                code: codeController.text,
                updatedAt: DateTime.now(),
              );
              context.read<SnippetProvider>().saveSnippet(updatedSnippet);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Snippet updated!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(
    BuildContext context,
    CodeSnippet snippet,
    SnippetProvider provider,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E24),
        title: const Text('Share Snippet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display full code in scrollable container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F13),
                border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                maxHeight: 200,
                maxWidth: 400,
              ),
              child: SingleChildScrollView(
                child: Text(
                  snippet.code,
                  style: const TextStyle(
                    fontFamily: 'Courier New',
                    fontSize: 11,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Copy Code Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      try {
                        Clipboard.setData(ClipboardData(text: snippet.code));
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: \$e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'python':
        return Colors.blue[300]!;
      case 'java':
        return Colors.orange[300]!;
      case 'c++':
        return Colors.purple[300]!;
      default:
        return Colors.grey[300]!;
    }
  }
}
