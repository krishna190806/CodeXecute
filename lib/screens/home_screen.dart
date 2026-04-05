import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/notification_service.dart';
import 'tasks_screen.dart';

/// LAB 10 – Home Screen
/// Three buttons: Instant Notification, Scheduled Notification, Print FCM Token.
/// Tapping a notification navigates to TasksScreen via payload handling in
/// NotificationService.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ── Helper to print & display the FCM Device Token ──
  Future<void> _printFCMToken(BuildContext context) async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('═══════════════════════════════════════');
    debugPrint('FCM Device Token: $token');
    debugPrint('═══════════════════════════════════════');

    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('FCM Token'),
        content: SelectableText(
          token ?? 'Token unavailable',
          style: const TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // ── App Bar ──
      appBar: AppBar(
        title: const Text('CodeXecute – Notifications'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──
            Icon(Icons.notifications_active,
                size: 72, color: theme.primaryColor),
            const SizedBox(height: 12),
            Text(
              'LAB 10 – Local & Push Alerts',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the buttons below to test notification features',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 40),

            // ── Button 1: Show Instant Notification ──
            _ActionCard(
              icon: Icons.flash_on,
              color: Colors.orange,
              title: 'Show Instant Notification',
              subtitle: 'Fires a local notification immediately',
              onTap: () async {
                await NotificationService.instance.showInstantNotification(
                  title: '🔔 CodeXecute Reminder',
                  body: 'Time to practice your coding skills!',
                  payload: 'instant_task',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Instant notification sent!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            // ── Button 2: Schedule Notification (10 seconds) ──
            _ActionCard(
              icon: Icons.schedule,
              color: Colors.blue,
              title: 'Schedule Notification (10 s)',
              subtitle: 'Local notification triggers after 10 seconds',
              onTap: () async {
                await NotificationService.instance.scheduleNotification(
                  id: 2001,
                  title: '⏰ Scheduled Reminder',
                  body: 'This was scheduled 10 seconds ago. Keep coding!',
                  delay: const Duration(seconds: 10),
                  payload: 'scheduled_task',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('⏰ Notification scheduled — wait 10 seconds'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            // ── Button 3: Print FCM Token ──
            _ActionCard(
              icon: Icons.vpn_key,
              color: Colors.purple,
              title: 'Print FCM Token',
              subtitle: 'Shows device token (used for push testing)',
              onTap: () => _printFCMToken(context),
            ),
            const SizedBox(height: 32),

            // ── Navigate to Tasks Screen manually ──
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TasksScreen()),
                );
              },
              icon: const Icon(Icons.task_alt),
              label: const Text('Go to Tasks Screen'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 32),

            // ── Quick Testing Guide ──
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: theme.primaryColor),
                        const SizedBox(width: 8),
                        const Text('Testing Guide',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const Divider(height: 20),
                    _guideRow('Foreground',
                        'Keep app open → tap "Instant Notification"'),
                    _guideRow('Background',
                        'Minimize app → send push from Firebase Console'),
                    _guideRow('Terminated',
                        'Kill app → send push → tap notification'),
                    _guideRow('Scheduled',
                        'Tap "Schedule" → wait 10 seconds'),
                    _guideRow('Tap Action',
                        'Tap any notification → navigates to Tasks'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Small helper for the testing guide rows ──
  static Widget _guideRow(String label, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green.shade400),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: detail),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Reusable card-style action button
// ─────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
