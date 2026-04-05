import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/notification_service.dart';

/// Model class for Task data
class Task {
  final String? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool isCompleted;
  final String priority; // 'High', 'Medium', 'Low'
  final String userId;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.dueDate,
    this.isCompleted = false,
    this.priority = 'Medium',
    required this.userId,
  });

  // Convert Task to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'isCompleted': isCompleted,
      'priority': priority,
      'userId': userId,
    };
  }

  // Create Task from Firestore document
  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dueDate: data['dueDate'] != null ? (data['dueDate'] as Timestamp).toDate() : null,
      isCompleted: data['isCompleted'] ?? false,
      priority: data['priority'] ?? 'Medium',
      userId: data['userId'] ?? '',
    );
  }

  // Create copy with updated fields
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? dueDate,
    bool? isCompleted,
    String? priority,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      userId: userId ?? this.userId,
    );
  }
}

/// State management for CRUD operations on tasks
/// Manages tasks list, real-time updates, and Firestore integration
class TaskProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  List<Task> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get totalTasks => _tasks.length;
  int get completedCount => completedTasks.length;
  int get pendingCount => pendingTasks.length;

  /// Initialize task provider and start listening to tasks
  Future<void> initializeProvider() async {
    await loadTasks();
    _listenToTaskChanges();
  }

  /// Load tasks from Firestore
  Future<void> loadTasks() async {
    _setLoading(true);
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        print('[TaskProvider] Loading tasks for user: ${currentUser.uid}');
        QuerySnapshot querySnapshot = await _firestore
            .collection('tasks')
            .where('userId', isEqualTo: currentUser.uid)
            .orderBy('createdAt', descending: true)
            .get();

        _tasks = querySnapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
        print('[TaskProvider] Loaded ${_tasks.length} tasks');
        _clearError();
      } else {
        _tasks = [];
        _setError('User not authenticated');
      }
    } catch (e) {
      _setError('Failed to load tasks: $e');
      print('❌ Load tasks error: $e');
    } finally {
      _setLoading(false);
      notifyListeners(); // Notify UI that loading is done
    }
  }

  /// Listen to real-time changes in tasks collection
  void _listenToTaskChanges() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _firestore
          .collection('tasks')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (QuerySnapshot querySnapshot) {
              _tasks = querySnapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
              _clearError();
              notifyListeners();
            },
            onError: (error) {
              _setError('Real-time sync failed: $error');
              print('Task stream error: $error');
            },
          );
    }
  }

  /// Add new task
  Future<bool> addTask({
    required String title,
    required String description,
    DateTime? dueDate,
    String priority = 'Medium',
  }) async {
    _setLoading(true);
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('User not authenticated');
        return false;
      }

      Task newTask = Task(
        title: title.trim(),
        description: description.trim(),
        createdAt: DateTime.now(),
        dueDate: dueDate,
        priority: priority,
        userId: currentUser.uid,
      );

      DocumentReference docRef = await _firestore.collection('tasks').add(newTask.toMap());
      
      // Add to local list immediately for better UX
      Task addedTask = newTask.copyWith(id: docRef.id);
      _tasks.insert(0, addedTask);
      
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to add task: $e');
      print('Add task error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update existing task
  Future<bool> updateTask({
    required String taskId,
    required String title,
    required String description,
    DateTime? dueDate,
    String? priority,
    bool? isCompleted,
  }) async {
    _setLoading(true);
    try {
      Map<String, dynamic> updateData = {
        'title': title.trim(),
        'description': description.trim(),
        'dueDate': dueDate != null ? Timestamp.fromDate(dueDate) : null,
      };

      if (priority != null) updateData['priority'] = priority;
      if (isCompleted != null) updateData['isCompleted'] = isCompleted;

      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('User not authenticated');
        return false;
      }

      await _firestore.collection('tasks').doc(taskId).update(updateData);

      // Update local list
      int index = _tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(
          title: title,
          description: description,
          dueDate: dueDate,
          priority: priority,
          isCompleted: isCompleted,
        );
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update task: $e');
      print('Update task error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Toggle task completion status
  Future<bool> toggleTaskCompletion(String taskId) async {
    try {
      int index = _tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        bool newStatus = !_tasks[index].isCompleted;
        User? currentUser = _auth.currentUser;
        if (currentUser == null) return false;
        
        await _firestore.collection('tasks').doc(taskId).update({
          'isCompleted': newStatus,
        });

        _tasks[index] = _tasks[index].copyWith(isCompleted: newStatus);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError('Failed to toggle task: $e');
      print('Toggle task error: $e');
      return false;
    }
  }

  /// Delete task
  Future<bool> deleteTask(String taskId) async {
    _setLoading(true);
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('User not authenticated');
        return false;
      }

      await _firestore.collection('tasks').doc(taskId).delete();
      
      // Remove from local list
      _tasks.removeWhere((task) => task.id == taskId);
      
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete task: $e');
      print('Delete task error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Get task by ID
  Task? getTaskById(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  /// Filter tasks by priority
  List<Task> getTasksByPriority(String priority) {
    return _tasks.where((task) => task.priority == priority).toList();
  }

  /// Get overdue tasks
  List<Task> getOverdueTasks() {
    DateTime now = DateTime.now();
    return _tasks.where((task) => 
      task.dueDate != null && 
      task.dueDate!.isBefore(now) && 
      !task.isCompleted
    ).toList();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
  }

  /// Clear all tasks (for testing/reset)
  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }

  // ──────────────────────────────────────────────────────────────────────────────
  //  NOTIFICATION INTEGRATION
  // ──────────────────────────────────────────────────────────────────────────────

  /// Schedule notification reminder when task is added with due date
  Future<void> scheduleNotificationForNewTask({
    required String taskId,
    required String title,
    DateTime? dueDate,
    String priority = 'Medium',
  }) async {
    if (dueDate == null || dueDate.isBefore(DateTime.now())) {
      return; // Don't schedule for past dates
    }

    await NotificationService.instance.scheduleTaskReminder(
      taskId: taskId,
      taskTitle: title,
      dueDate: dueDate,
      priority: priority,
    );
  }

  /// Cancel notification for a task
  Future<void> cancelTaskNotification(String taskId) async {
    await NotificationService.instance.cancelTaskReminder(taskId);
  }

  /// Send notification when task is completed
  Future<void> notifyTaskCompletionSuccess(String taskTitle) async {
    await NotificationService.instance.notifyTaskCompleted(
      taskTitle: taskTitle,
    );
  }

  /// Send notification for task updates
  Future<void> notifyTaskUpdated({
    required String taskId,
    required String taskTitle,
    required String updateMessage,
  }) async {
    await NotificationService.instance.notifyTaskUpdate(
      taskId: taskId,
      taskTitle: taskTitle,
      updateMessage: updateMessage,
    );
  }

  /// Override addTask to enable notifications for new tasks
  Future<bool> addTaskWithNotification({
    required String title,
    required String description,
    DateTime? dueDate,
    String priority = 'Medium',
    bool enableNotification = true,
  }) async {
    _setLoading(true);
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('User not authenticated');
        return false;
      }

      Task newTask = Task(
        title: title.trim(),
        description: description.trim(),
        createdAt: DateTime.now(),
        dueDate: dueDate,
        priority: priority,
        userId: currentUser.uid,
      );

      DocumentReference docRef = await _firestore.collection('tasks').add(newTask.toMap());
      
      // Add to local list immediately for better UX
      Task addedTask = newTask.copyWith(id: docRef.id);
      _tasks.insert(0, addedTask);
      
      // Schedule notification if enabled
      if (enableNotification && dueDate != null) {
        await scheduleNotificationForNewTask(
          taskId: docRef.id,
          title: title,
          dueDate: dueDate,
          priority: priority,
        );
      }
      
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to add task: $e');
      print('Add task error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Get count of overdue tasks with pending notifications
  List<Task> getOverdueTasksWithNotifications() {
    final overdue = getOverdueTasks();
    return overdue.where((task) => task.priority == 'High').toList();
  }
}