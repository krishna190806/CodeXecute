import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'CodeXecute',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black54),
            tooltip: 'Logout',
            onPressed: () async {
              // Logout: StreamBuilder in main.dart will auto-redirect to Login
              await FirebaseAuth.instance.signOut();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                radius: 16,
                child: const Icon(Icons.person, size: 20, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Text(
              'Welcome, User!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'What would you like to build today?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),

            // Feature Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildFeatureCard(
                    context,
                    title: 'New Code',
                    icon: Icons.add_circle_outline,
                    color: Colors.blueAccent,
                    onTap: () {},
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Saved Codes',
                    icon: Icons.save_outlined,
                    color: Colors.orangeAccent,
                    onTap: () {},
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Playground',
                    icon: Icons.code,
                    color: Colors.purpleAccent,
                    onTap: () {},
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Settings',
                    icon: Icons.settings_outlined,
                    color: Colors.grey,
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Quick Run'),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
