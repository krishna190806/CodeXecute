import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/settings_screen.dart';
import 'firebase_options.dart'; // Import the new options file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with platform-specific options (Required for Web)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
  
  runApp(const CodeXecuteApp());
}

class CodeXecuteApp extends StatelessWidget {
  const CodeXecuteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeXecute Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: const Color(0xFF5C6BC0), // Indigo 400
        scaffoldBackgroundColor: Colors.grey[50], // Light background
        fontFamily: 'Roboto', // Default Material font, can be changed
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5C6BC0),
          brightness: Brightness.light,
        ),
      ),
      // Use StreamBuilder to listen to auth state changes
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // If user is logged in, show Dashboard
            if (snapshot.hasData) {
              return const DashboardScreen();
            }
            // If user is not logged in, show Login
            return const LoginScreen();
          }
           // While checking auth state, show loading indicator
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
