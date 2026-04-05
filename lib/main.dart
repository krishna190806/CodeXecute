import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart' as auth_prov;
import 'providers/task_provider.dart';
import 'providers/snippet_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/history_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen_new.dart';
import 'screens/registration_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/add_edit_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/posts_screen.dart';
import 'screens/compiler_screen.dart';
import 'screens/language_info_screen.dart';
import 'services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart'; // Import the new options file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences (required for all features)
  final prefs = await SharedPreferences.getInstance();
  
  // Initialize Firebase with platform-specific options (Required for Web)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  // Register FCM background handler (not supported on web)
  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // Initialize Notification Service (local + push)
  try {
    await NotificationService.instance.initialize();
  } catch (e) {
    print('Notification service initialization failed: $e');
  }
  
  runApp(CodeXecuteApp(prefs: prefs));
}

class CodeXecuteApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const CodeXecuteApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    // Wrap entire app with MultiProvider for state management
    return MultiProvider(
      providers: [
        // Authentication Provider - handles login/logout state
        ChangeNotifierProvider(create: (context) => auth_prov.AuthProvider()),
        // Task Provider - handles CRUD operations 
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        // Snippet Provider - manages code snippets and favorites
        ChangeNotifierProvider(create: (context) => SnippetProvider(prefs)),
        // Settings Provider - manages theme, font size, shortcuts
        ChangeNotifierProvider(create: (context) => SettingsProvider(prefs)),
        // History Provider - tracks code execution history
        ChangeNotifierProvider(create: (context) => HistoryProvider(prefs)),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'CodeXecute Auth Demo',
            debugShowCheckedModeBanner: false,
            navigatorKey: NotificationService.navigatorKey,
            themeMode: settings.themeMode == 'light' 
                ? ThemeMode.light 
                : (settings.themeMode == 'dark' ? ThemeMode.dark : ThemeMode.system),
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF6366F1),
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6366F1),
                brightness: Brightness.light,
                background: const Color(0xFFF8F9FA),
                surface: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF6366F1),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardThemeData(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFF6366F1),
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF6366F1), // Modern premium Indigo
          scaffoldBackgroundColor: const Color(0xFF0F0F13), // Deep dark, nearly black background
          fontFamily: 'Roboto', // Or 'Inter' if available
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.dark,
            background: const Color(0xFF0F0F13),
            surface: const Color(0xFF1E1E24), // Distinct surface color for cards
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0F0F13),
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(color: Colors.white70),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF1E1E24),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF16161D),
            selectedItemColor: Color(0xFF6366F1),
            unselectedItemColor: Colors.grey,
          ),
        ),
        // Use Consumer to listen to auth state changes
        home: Consumer<auth_prov.AuthProvider>(
          builder: (context, authProvider, child) {
            // Show loading screen while checking authentication
            if (authProvider.isLoading) {
              return const SplashScreen();
            }
            
            // If user is logged in, show Dashboard and initialize TaskProvider
            if (authProvider.isLoggedIn) {
              // Initialize task provider when user logs in
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<TaskProvider>(context, listen: false).initializeProvider();
              });
              return const DashboardScreenNew();
            }
            
            // If user is not logged in, show Login
            return const LoginScreen();
          },
        ),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreenNew(),
          '/register': (context) => const RegistrationScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/notifications': (context) => const NotificationsScreen(),
          '/posts': (context) => const PostsScreen(),
          '/compiler': (context) => const CompilerScreen(),
          '/language_info': (context) => const LanguageInfoScreen(),
        },
      );
        },
      ),
    );
  }
}
