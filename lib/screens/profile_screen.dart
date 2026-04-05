import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? 'User Name';
    final email = user?.email ?? 'user@example.com';
    final photoUrl = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return ListView(
            children: [
              // User Profile Section
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                  child: photoUrl == null
                      ? Icon(Icons.person, size: 60, color: Theme.of(context).primaryColor)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showEditProfileDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About App'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'CodeXecute',
                    applicationVersion: '1.0.0',
                    children: const [
                      Text('Lab 7: Productivity App Implementation'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // Detailed Settings Section
              _buildSectionHeader('Appearance'),
              _buildSettingTile(
                icon: Icons.dark_mode,
                title: 'Theme',
                subtitle: _getThemeLabel(settings.themeMode),
                onTap: () => _showThemeDialog(context, settings),
              ),

              _buildSettingTile(
                icon: Icons.text_fields,
                title: 'Editor Font Size',
                subtitle: '${settings.fontSize.toInt()}px',
                onTap: () => _showFontSizeDialog(context, settings),
              ),

              _buildSettingTile(
                icon: Icons.palette,
                title: 'Syntax Theme',
                subtitle: _getSyntaxLabel(settings.syntaxTheme),
                onTap: () => _showSyntaxThemeDialog(context, settings),
              ),

              const Divider(height: 32),

              _buildSectionHeader('Editor'),
              _buildSwitchTile(
                icon: Icons.keyboard,
                title: 'Keyboard Shortcuts',
                subtitle: 'Ctrl+Enter to run, Ctrl+S to save',
                value: settings.keyboardShortcutsEnabled,
                onChanged: (value) => settings.setKeyboardShortcuts(value),
              ),

              _buildSwitchTile(
                icon: Icons.format_indent_increase,
                title: 'Auto Format',
                subtitle: 'Automatically format code on save',
                value: settings.autoFormatEnabled,
                onChanged: (value) => settings.setAutoFormat(value),
              ),

              const Divider(height: 32),

              _buildSectionHeader('Offline & Storage'),
              _buildSwitchTile(
                icon: Icons.cloud_off,
                title: 'Offline Mode',
                subtitle: 'Save work locally when offline',
                value: settings.offlineEnabled,
                onChanged: (value) => settings.setOfflineMode(value),
              ),

              _buildSettingTile(
                icon: Icons.delete_sweep,
                title: 'Clear Cache',
                subtitle: 'Remove cached code and history',
                onTap: () => _showClearCacheDialog(context),
              ),

              const Divider(height: 32),

              _buildSectionHeader('About'),
              _buildSettingTile(
                icon: Icons.info,
                title: 'App Version',
                subtitle: 'CodeXecute v1.0.0',
              ),

              _buildSettingTile(
                icon: Icons.help,
                title: 'Keyboard Shortcuts Help',
                subtitle: 'View all available shortcuts',
                onTap: () => _showKeyboardHelp(context),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if(context.mounted) Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  void _showThemeDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(context, settings, 'light', 'Light'),
            _buildThemeOption(context, settings, 'dark', 'Dark'),
            _buildThemeOption(context, settings, 'auto', 'System Default'),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    SettingsProvider settings,
    String value,
    String label,
  ) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: value,
        groupValue: settings.themeMode,
        onChanged: (val) {
          if (val != null) {
            settings.setThemeMode(val);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Font Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: settings.fontSize,
              min: 10,
              max: 24,
              divisions: 7,
              label: '${settings.fontSize.toInt()}px',
              onChanged: (value) {
                settings.setFontSize(value);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 60,
              child: Text(
                'Preview: This is sample code text',
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showSyntaxThemeDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Syntax Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSyntaxOption(context, settings, 'atom', 'Atom'),
            _buildSyntaxOption(context, settings, 'github', 'GitHub'),
            _buildSyntaxOption(context, settings, 'monokai', 'Monokai'),
          ],
        ),
      ),
    );
  }

  Widget _buildSyntaxOption(
    BuildContext context,
    SettingsProvider settings,
    String value,
    String label,
  ) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: value,
        groupValue: settings.syntaxTheme,
        onChanged: (val) {
          if (val != null) {
            settings.setSyntaxTheme(val);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all cached code snippets and execution history. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showKeyboardHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keyboard Shortcuts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ShortcutItem('Ctrl + Enter', 'Run code'),
            _ShortcutItem('Ctrl + S', 'Save snippet'),
            _ShortcutItem('Ctrl + K', 'Clear output'),
            _ShortcutItem('Ctrl + L', 'Select all code'),
            _ShortcutItem('Tab', 'Indent'),
            _ShortcutItem('Shift + Tab', 'Unindent'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _getThemeLabel(String mode) {
    switch (mode) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'auto':
        return 'System Default';
      default:
        return 'Dark';
    }
  }

  String _getSyntaxLabel(String theme) {
    switch (theme) {
      case 'atom':
        return 'Atom';
      case 'github':
        return 'GitHub';
      case 'monokai':
        return 'Monokai';
      default:
        return 'Atom';
    }
  }
}

class _ShortcutItem extends StatelessWidget {
  final String shortcut;
  final String description;

  const _ShortcutItem(this.shortcut, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              shortcut,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'Courier New',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
