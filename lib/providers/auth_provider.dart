import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// State management for authentication and session persistence
/// Manages login state, user data, and session storage
class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = true;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get userDisplayName => _currentUser?.displayName ?? _currentUser?.email?.split('@')[0] ?? 'User';

  AuthProvider() {
    _initializeAuth();
  }

  /// Initialize authentication state on app start
  Future<void> _initializeAuth() async {
    try {
      // Check stored session
      await _checkStoredSession();
      
      // Listen to auth state changes
      _auth.authStateChanges().listen((User? user) async {
        _currentUser = user;
        _isLoggedIn = user != null;
        
        // Store session state
        await _saveSessionState(_isLoggedIn);
        
        _isLoading = false;
        notifyListeners();
      });
      
    } catch (e) {
      print('Auth initialization error: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Check if user session is stored locally
  Future<void> _checkStoredSession() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? storedLoginState = prefs.getBool('isLoggedIn');
      
      if (storedLoginState == true) {
        // If stored session exists, wait for Firebase to confirm
        _currentUser = _auth.currentUser;
        _isLoggedIn = _currentUser != null;
      }
    } catch (e) {
      print('Error checking stored session: $e');
    }
  }

  /// Save session state to SharedPreferences
  Future<void> _saveSessionState(bool loginState) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', loginState);
      
      if (loginState && _currentUser != null) {
        await prefs.setString('userEmail', _currentUser!.email ?? '');
        await prefs.setString('userId', _currentUser!.uid);
      } else {
        await prefs.remove('userEmail');
        await prefs.remove('userId');
      }
    } catch (e) {
      print('Error saving session state: $e');
    }
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      print('AuthProvider: Starting login for email: $email');
      _isLoading = true;
      notifyListeners();

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      print('AuthProvider: Login successful for user: ${result.user?.uid}');
      _currentUser = result.user;
      _isLoggedIn = _currentUser != null;
      
      await _saveSessionState(_isLoggedIn);
      
      _isLoading = false;
      notifyListeners();
      
      return true;
    } on FirebaseAuthException catch (e) {
      print('AuthProvider: Firebase Auth Error - Code: ${e.code}, Message: ${e.message}');
      _isLoading = false;
      notifyListeners();
      throw _getAuthErrorMessage(e);
    } catch (e) {
      print('AuthProvider: General Error - $e');
      _isLoading = false;
      notifyListeners();
      throw 'Login failed: $e';
    }
  }

  /// Register new user
  Future<bool> register(String email, String password, String displayName) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      // Update display name
      await result.user?.updateDisplayName(displayName);
      
      _currentUser = result.user;
      _isLoggedIn = _currentUser != null;
      
      await _saveSessionState(_isLoggedIn);
      
      _isLoading = false;
      notifyListeners();
      
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _getAuthErrorMessage(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw 'Registration failed: $e';
    }
  }

  /// Logout user and clear session
  Future<void> logout() async {
    try {
      await _auth.signOut();
      
      // Clear stored session
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userEmail');
      await prefs.remove('userId');
      
      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
      
    } catch (e) {
      print('Logout error: $e');
      throw 'Logout failed: $e';
    }
  }

  /// Get user-friendly error messages
  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'Signing in with Email and Password is not enabled.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _getAuthErrorMessage(e);
    } catch (e) {
      throw 'Password reset failed: $e';
    }
  }
}