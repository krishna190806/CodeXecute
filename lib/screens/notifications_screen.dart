import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Icon(Icons.notifications_active_outlined,
                size: 64, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(
              'Local & Push Notifications',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Test notification features below',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // ── LOCAL NOTIFICATIONS SECTION ──
            _sectionHeader(context, 'Local Notifications'),
            const SizedBox(height: 12),

            // Instant notification button
            _NotificationButton(
              icon: Icons.flash_on,
              color: Colors.orange,
              title: 'Instant Notification',
              subtitle: 'Shows immediately',
              onTap: () async {
                await NotificationService.instance.showInstantNotification(
                  title: '🔔 CodeXecute Reminder',
                  body: 'Time to practice your coding skills!',
                  payload: 'instant_task',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Instant notification sent!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),

            // Scheduled notification button (10 seconds)
            _NotificationButton(
              icon: Icons.schedule,
              color: Colors.blue,
              title: 'Scheduled Notification',
              subtitle: 'Triggers after 10 seconds',
              onTap: () async {
                await NotificationService.instance.scheduleNotification(
                  id: 1001,
                  title: '⏰ Scheduled Reminder',
                  body: 'This was scheduled 10 seconds ago. Keep coding!',
                  delay: const Duration(seconds: 10),
                  payload: 'scheduled_task',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification scheduled for 10 seconds!'),
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),

            // Cancel all
            _NotificationButton(
              icon: Icons.cancel_outlined,
              color: Colors.red,
              title: 'Cancel All Notifications',
              subtitle: 'Removes pending scheduled notifications',
              onTap: () async {
                await NotificationService.instance.cancelAll();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All notifications cancelled'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 32),

            // ── TASK REMINDERS SECTION ──
            _sectionHeader(context, 'Task Reminders'),
            const SizedBox(height: 12),

            // Task reminder button
            _NotificationButton(
              icon: Icons.task_alt,
              color: Colors.teal,
              title: 'Schedule Task Reminder',
              subtitle: 'Reminder for a task due in 5 minutes',
              onTap: () async {
                final dueDate = DateTime.now().add(const Duration(minutes: 5));
                await NotificationService.instance.scheduleTaskReminder(
                  taskId: 'sample_task_${DateTime.now().millisecondsSinceEpoch}',
                  taskTitle: 'Complete Practice Exercise',
                  dueDate: dueDate,
                  priority: 'High',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task reminder scheduled (1 hour before due time)!'),
                      backgroundColor: Colors.teal,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),

            // Daily practice reminder button
            _NotificationButton(
              icon: Icons.repeat_outlined,
              color: const Color(0xFF9C27B0),
              title: 'Daily Practice Reminder',
              subtitle: 'Reminder at 9:00 AM every day',
              onTap: () async {
                await NotificationService.instance.scheduleDailyReminder(
                  hour: 9,
                  minute: 0,
                  title: '📚 Time to Code!',
                  body: 'Your daily practice session is waiting. Keep up the momentum!',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Daily reminder set for 9:00 AM!'),
                      backgroundColor: Color(0xFF9C27B0),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),

            // Task completion notification
            _NotificationButton(
              icon: Icons.check_circle_outline,
              color: Colors.green,
              title: 'Task Completed',
              subtitle: 'Celebrate a task completion!',
              onTap: () async {
                await NotificationService.instance.notifyTaskCompleted(
                  taskTitle: 'Build Flutter Chat App',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task completion notification sent!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),

            // Task update notification
            _NotificationButton(
              icon: Icons.update_outlined,
              color: Colors.amber,
              title: 'Task Update',
              subtitle: 'Notify about task changes',
              onTap: () async {
                await NotificationService.instance.notifyTaskUpdate(
                  taskId: 'sample_task',
                  taskTitle: 'API Integration',
                  updateMessage: 'Due date extended to tomorrow. Requirements updated.',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task update notification sent!'),
                      backgroundColor: Colors.amber,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 32),

            // ── APP NOTIFICATIONS SECTION ──
            _sectionHeader(context, 'App Notifications'),
            const SizedBox(height: 12),

            // App update notification
            _NotificationButton(
              icon: Icons.extension_outlined,
              color: Colors.indigoAccent,
              title: 'App Update Available',
              subtitle: 'Announce new features & updates',
              onTap: () async {
                await NotificationService.instance.notifyAppUpdate(
                  title: 'New Features Available!',
                  body: 'Update CodeXecute to v2.1.0 for improved performance and new languages!',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('App update notification sent!'),
                      backgroundColor: Colors.indigoAccent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 32),

            // ── FCM TOKEN DISPLAY ──
            _sectionHeader(context, 'FCM Setup for Push Notifications'),
            const SizedBox(height: 12),
            FutureBuilder<String?>(
              future: NotificationService.instance.getDeviceToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final token = snapshot.data ?? 'Failed to load token';
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.vpn_key_outlined,
                                color: Colors.blue.shade400, size: 24),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Your FCM Token (for testing)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              token,
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Token copied to clipboard!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text('Copy Token'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '📌 How to test Push Notifications:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _stepRow('1', 'Copy your FCM token above'),
                        const SizedBox(height: 4),
                        _stepRow('2', 'Go to Firebase Console → Cloud Messaging'),
                        const SizedBox(height: 4),
                        _stepRow('3', 'Create new campaign'),
                        const SizedBox(height: 4),
                        _stepRow('4', 'Add test message with title & body'),
                        const SizedBox(height: 4),
                        _stepRow('5', 'Add recipient email or FCM token'),
                        const SizedBox(height: 4),
                        _stepRow('6', 'Publish and test notification delivery'),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // ── TESTING GUIDE ──
            _sectionHeader(context, 'Testing Guide'),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TestItem(
                      label: 'Foreground',
                      detail: 'Keep app open → tap "Instant Notification"',
                    ),
                    SizedBox(height: 8),
                    _TestItem(
                      label: 'Background',
                      detail: 'Minimize app → send FCM from console',
                    ),
                    SizedBox(height: 8),
                    _TestItem(
                      label: 'Terminated',
                      detail: 'Kill app → send FCM → tap notification',
                    ),
                    SizedBox(height: 8),
                    _TestItem(
                      label: 'Scheduled',
                      detail: 'Tap "Scheduled" → wait 10 seconds',
                    ),
                    SizedBox(height: 8),
                    _TestItem(
                      label: 'Tap Action',
                      detail: 'Tap any notification → navigates to Tasks',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  static Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Icon(Icons.check_circle, size: 16, color: Colors.green.shade400),
        const SizedBox(width: 8),
        Text('$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
        ),
      ],
    );
  }

  static Widget _stepRow(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.purple.shade100,
          child: Text(number,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
        ),
      ],
    );
  }
}

// ─── Reusable notification action button ───

class _NotificationButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NotificationButton({
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
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

// ─── Test guide item ───

class _TestItem extends StatelessWidget {
  final String label;
  final String detail;

  const _TestItem({required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.bug_report_outlined, size: 18, color: Colors.grey.shade500),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
    );
  }
}
