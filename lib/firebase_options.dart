// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // TODO: Add Web app in Firebase Console to get these values
      // Go to: Firebase Console → Project settings → Your apps → Add app → Web (</>)
      // Then replace these placeholder values with your actual Web config
      return const FirebaseOptions(
        apiKey: "AIzaSyCLh5RNHT13jS0McFKpzcf0C9WnQGtHx1s",
        appId: "1:529708407713:web:d053d3d85d2181e5f889e0",
        messagingSenderId: "52970840771",
        projectId: "codexecute-5dbe8",
        authDomain: "codexecute-5dbe8.firebaseapp.com",
        storageBucket: "codexecute-5dbe8.firebasestorage.app",
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Android configuration from google-services.json
        return const FirebaseOptions(
          apiKey: "AIzaSyDwF-eMQYKVGrN84Jljqoc7zeBITrhrZ10",
          appId: "1:529708407713:android:48eec1e1f1c802d2f889e0",
          messagingSenderId: "529708407713",
          projectId: "codexecute-5dbe8",
          storageBucket: "codexecute-5dbe8.firebasestorage.app",
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
