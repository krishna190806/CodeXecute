import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as auth_prov;
import '../providers/task_provider.dart';
import '../screens/snippets_list_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_detail_screen.dart';

class DashboardScreenNew extends StatelessWidget {
  const DashboardScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<auth_prov.AuthProvider, TaskProvider>(
      builder: (context, authProvider, taskProvider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'CodeXecute',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white70),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    radius: 16,
                    child: const Icon(Icons.person, size: 20, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          drawer: _buildNavigationDrawer(context, authProvider),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${authProvider.userDisplayName}!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your tasks and notes efficiently',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 16),
                
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildFeatureCard(
                        context,
                        title: 'Compiler',
                        icon: Icons.code,
                        color: Colors.blue,
                        onTap: () {
                          Navigator.pushNamed(context, '/compiler');
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'Snippets',
                        icon: Icons.bookmark,
                        color: Colors.cyan,
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SnippetsListScreen()));
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'History',
                        icon: Icons.history,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const HistoryScreen()));
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'Profile',
                        icon: Icons.person,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'Settings',
                        icon: Icons.settings,
                        color: Colors.indigo,
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SettingsDetailScreen()));
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'Notifications',
                        icon: Icons.notifications,
                        color: Colors.red,
                        onTap: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationDrawer(BuildContext context, auth_prov.AuthProvider authProvider) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            accountName: Text(
              authProvider.userDisplayName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            accountEmail: Text(
              authProvider.currentUser?.email ?? '',
              style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.code,
                  title: 'Compiler',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/compiler');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bookmark_outline,
                  title: 'Snippets',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SnippetsListScreen()));
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.history,
                  title: 'History',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsDetailScreen()));
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  textColor: Colors.red,
                  onTap: () async {
                    Navigator.pop(context);
                    await _handleLogout(context, authProvider);
                  },
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'CodeXecute v1.0.0',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    final defaultColor = Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8);
    return ListTile(
      leading: Icon(icon, color: textColor ?? defaultColor),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? defaultColor),
      ),
      onTap: onTap,
      dense: true,
    );
  }

  Future<void> _handleLogout(BuildContext context, auth_prov.AuthProvider authProvider) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await authProvider.logout();
      
      if (context.mounted) Navigator.of(context).pop();
      
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor,
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}