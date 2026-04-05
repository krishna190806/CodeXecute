import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Top-level handler for background / terminated FCM messages.
/// Must be a top-level function (not a class method).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background message: ${message.messageId}');
}

class NotificationService {
  // Singleton
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Store a global navigator key so we can navigate from notification taps
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Android notification channel
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'codexecute_channel', // id
    'CodeXecute Notifications', // name
    description: 'Notifications for practice reminders & updates',
    importance: Importance.high,
  );

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  INITIALIZATION
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> initialize() async {
    // Local notifications only work on mobile platforms, not web
    if (!kIsWeb) {
      // 1. Initialize timezone data (needed for zonedSchedule)
      tz.initializeTimeZones();

      // 2. Create the Android notification channel
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      // 3. Initialize flutter_local_notifications
      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidInit);

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );
    }

    // 4. Request notification permission (Android 13+ / Web)
    await _requestPermissions();

    // 5. Setup Firebase Cloud Messaging
    await _setupFCM();
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  PERMISSIONS
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> _requestPermissions() async {
    // FCM permission request (covers Android 13+ POST_NOTIFICATIONS)
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('[Notification] Permission status: ${settings.authorizationStatus}');

    // Also request from local notifications plugin on Android (not web)
    if (!kIsWeb) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  FCM SETUP
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> _setupFCM() async {
    // Print FCM token (use this to send test push from Firebase Console)
    final token = await _firebaseMessaging.getToken();
    debugPrint('â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•');
    debugPrint('FCM Token: $token');
    debugPrint('â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background (but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Handle notification tap when app was terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  FCM HANDLERS
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Foreground: show a local notification so the user sees it.
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[FCM] Foreground message: ${message.notification?.title}');

    final notification = message.notification;
    if (notification == null || kIsWeb) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title ?? 'CodeXecute',
      notification.body ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: message.data['taskId'] ?? 'no_payload',
    );
  }

  /// Background / terminated: user tapped the notification.
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('[FCM] Opened app via notification: ${message.data}');
    final taskId = message.data['taskId'];
    final screen = message.data['screen'] ?? '/tasks';
    
    if (taskId != null) {
      // Navigate with task context
      navigatorKey.currentState?.pushNamed(screen, arguments: taskId);
    } else {
      navigatorKey.currentState?.pushNamed(screen);
    }
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  LOCAL NOTIFICATION TAP
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _onNotificationTap(NotificationResponse response) {
    debugPrint('[Local] Notification tapped, payload: ${response.payload}');
    final payload = response.payload;
    
    if (payload != null && payload.isNotEmpty && payload != 'no_payload') {
      // Handle different notification types based on payload
      if (payload.startsWith('task_')) {
        final taskId = payload.replaceFirst('task_', '');
        navigatorKey.currentState?.pushNamed('/tasks', arguments: taskId);
      } else if (payload == 'daily_practice_reminder') {
        navigatorKey.currentState?.pushNamed('/dashboard');
      } else if (payload == 'app_update') {
        navigatorKey.currentState?.pushNamed('/settings');
      } else {
        // Default navigation
        navigatorKey.currentState?.pushNamed('/dashboard');
      }
    }
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  SHOW INSTANT LOCAL NOTIFICATION
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> showInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (kIsWeb) {
      debugPrint('[Notification] Local notifications not supported on web');
      return;
    }
    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: payload ?? 'instant_notification',
    );
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  SCHEDULED LOCAL NOTIFICATION
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required Duration delay,
    String? payload,
  }) async {
    if (kIsWeb) {
      debugPrint('[Notification] Scheduled notifications not supported on web');
      return;
    }
    final scheduledDate = tz.TZDateTime.now(tz.local).add(delay);

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null, // one-shot; use DateTimeComponents.time for daily
      payload: payload ?? 'scheduled_notification',
    );
  }

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  //  CANCEL
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _localNotifications.cancelAll();
  }

  // ──────────────────────────────────────────────────────────────────────────────
  //  TASK-BASED NOTIFICATIONS
  // ──────────────────────────────────────────────────────────────────────────────

  /// Schedule a notification for a new task
  Future<void> scheduleTaskReminder({
    required String taskId,
    required String taskTitle,
    required DateTime dueDate,
    String? priority,
  }) async {
    if (kIsWeb) return;

    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      debugPrint('[TaskReminder] Due date is in the past, skipping reminder');
      return;
    }

    // Schedule 1 hour before due date
    final reminderTime = dueDate.subtract(const Duration(hours: 1));
    final delayUntilReminder = reminderTime.difference(now);

    if (delayUntilReminder.isNegative) {
      debugPrint('[TaskReminder] Reminder time already passed');
      return;
    }

    final notificationId = taskId.hashCode;
    final priorityEmoji = priority == 'High' ? '🔴' : 
                          priority == 'Medium' ? '🟡' : '🟢';

    await scheduleNotification(
      id: notificationId,
      title: '$priorityEmoji Task Reminder: $taskTitle',
      body: 'Due in 1 hour. Time to focus and complete this task!',
      delay: delayUntilReminder,
      payload: 'task_$taskId',
    );

    debugPrint('[TaskReminder] Scheduled for task: $taskId at $reminderTime');
  }

  /// Schedule daily practice reminder at specific time
  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    String title = '📚 Daily Practice',
    String body = 'Time to practice your coding skills!',
  }) async {
    if (kIsWeb) return;

    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    // If the time has already passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _localNotifications.zonedSchedule(
      'daily_practice'.hashCode,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeats daily
      payload: 'daily_practice_reminder',
    );

    debugPrint('[DailyReminder] Scheduled for $hour:$minute daily');
  }

  /// Send immediate notification for task completion
  Future<void> notifyTaskCompleted({
    required String taskTitle,
  }) async {
    if (kIsWeb) return;

    await showInstantNotification(
      title: '✅ Task Completed!',
      body: 'Great job completing: $taskTitle',
      payload: 'task_completed',
    );
  }

  /// Send notification for task updates/comments
  Future<void> notifyTaskUpdate({
    required String taskId,
    required String taskTitle,
    required String updateMessage,
  }) async {
    if (kIsWeb) return;

    await showInstantNotification(
      title: '🔔 Task Update: $taskTitle',
      body: updateMessage,
      payload: 'task_update_$taskId',
    );
  }

  /// Send app update/announcement notification
  Future<void> notifyAppUpdate({
    required String title,
    required String body,
  }) async {
    if (kIsWeb) return;

    await showInstantNotification(
      title: '📢 $title',
      body: body,
      payload: 'app_update',
    );
  }

  /// Cancel a specific task reminder
  Future<void> cancelTaskReminder(String taskId) async {
    if (kIsWeb) return;
    final notificationId = taskId.hashCode;
    await _localNotifications.cancel(notificationId);
    debugPrint('[TaskReminder] Cancelled for task: $taskId');
  }

  /// Get FCM device token (useful for testing push notifications)
  Future<String?> getDeviceToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('[FCM] Error getting token: $e');
      return null;
    }
  }

  /// Subscribe to notification topic for group messaging
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('[FCM] Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('[FCM] Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from notification topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('[FCM] Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('[FCM] Error unsubscribing from topic: $e');
    }
  }
}
