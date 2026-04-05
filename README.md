<div align="center">

# 🚀 CodeXecute

### A Multi-Language Mobile Code Execution Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.10.7+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**Write, compile, and execute code in Python, Java, and C++ — right from your phone.**

---

</div>

## 📖 About

**CodeXecute** is a feature-rich mobile application built with Flutter that provides a portable code execution environment for programmers, students, and coding enthusiasts. It eliminates the need for desktop IDEs by letting you write and run code directly on your mobile device through integration with the [Wandbox](https://wandbox.org/) online compiler API.

> Whether you're commuting, on a study break, or away from your computer — CodeXecute keeps you coding.

---

## ✨ Features

### 🖥️ Multi-Language Code Compiler
- **Python** (CPython 3.14) — Blue & Yellow theme
- **Java** (OpenJDK 22+) — Red & Orange theme
- **C++** (GCC 13.2.0) — Blue & Cyan theme
- Built-in code editor with monospace font and syntax highlighting
- Custom **stdin input** support for interactive programs
- Real-time output with color-coded success/error indicators
- Code templates, formatting, and clipboard integration

### 📝 Code Snippet Management
- Save, organize, and manage code snippets across all languages
- Pre-built snippet library with common patterns (Hello World, loops, data structures, algorithms)
- Favorite, tag, and track usage of your snippets

### 📜 Execution History
- Automatic logging of every code execution
- Tracks source code, language, output, execution time, and success/failure status
- Review past programs and their results anytime

### 🔐 Authentication & Security
- Secure email-based registration and login via **Firebase Authentication**
- Session persistence with auto-login across app restarts
- Password reset via email
- Comprehensive input validation and error handling

### 📋 Notes & Tasks (CRUD)
- Full **Create, Read, Update, Delete** operations powered by **Cloud Firestore**
- Real-time synchronization across sessions
- Task completion tracking with toggle support

### 🔔 Notifications
- **Local notifications** — instant and scheduled (timezone-aware)
- **Push notifications** via Firebase Cloud Messaging (FCM)
- Task reminders, daily practice reminders, and completion celebrations
- Deep-link navigation from notification taps

### ⚙️ Settings & Customization
- Theme modes: Light, Dark, System
- Configurable editor font size and syntax highlighting theme
- Keyboard shortcuts and auto-formatting toggles
- Offline mode support

### 🌐 API Integration
- JSONPlaceholder API demo with pull-to-refresh
- Loading states, error handling, and retry mechanisms

---

## 🏗️ Architecture

CodeXecute follows a **layered architecture** with clear separation of concerns:

```
lib/
├── main.dart                    # App entry point & MultiProvider setup
├── firebase_options.dart        # Firebase configuration
│
├── models/                      # Data models
│   ├── code_snippet.dart        # Code snippet model with JSON serialization
│   ├── code_execution.dart      # Execution history record model
│   └── post.dart                # API post model
│
├── providers/                   # State management (ChangeNotifier)
│   ├── auth_provider.dart       # Authentication state
│   ├── task_provider.dart       # Notes & tasks state
│   ├── snippet_provider.dart    # User snippet management
│   ├── code_snippets_provider.dart  # Pre-built code templates
│   ├── settings_provider.dart   # User preferences
│   └── history_provider.dart    # Execution history tracking
│
├── services/                    # Business logic & external APIs
│   ├── compiler_service.dart    # Wandbox API integration
│   ├── compiler_utils.dart      # Code formatting & error analysis
│   ├── firestore_service.dart   # Cloud Firestore CRUD operations
│   ├── notification_service.dart # Local & push notifications
│   └── post_api_service.dart    # JSONPlaceholder API
│
├── screens/                     # UI screens (17 screens)
│   ├── splash_screen.dart       # Animated splash with auth check
│   ├── login_screen.dart        # Email/password login
│   ├── registration_screen.dart # New user registration
│   ├── forgot_password_screen.dart # Password reset
│   ├── dashboard_screen.dart    # Main hub with feature grid
│   ├── dashboard_screen_new.dart # Enhanced dashboard
│   ├── compiler_screen.dart     # Code editor & execution
│   ├── snippets_list_screen.dart # Snippet management
│   ├── history_screen.dart      # Execution history
│   ├── profile_screen.dart      # User profile & settings
│   ├── settings_screen.dart     # App settings
│   ├── settings_detail_screen.dart # Detailed settings
│   ├── notifications_screen.dart # Notification testing
│   ├── posts_screen.dart        # API data display
│   ├── language_info_screen.dart # Language documentation
│   ├── home_screen.dart         # Home view
│   └── add_edit_screen.dart     # Note/task editor
│
└── widgets/                     # Reusable components
    ├── custom_text_field.dart    # Styled text input
    ├── language_info_card.dart   # Language info display
    └── syntax_highlighter.dart  # Code syntax highlighting
```

### State Management

The app uses the **Provider** pattern with `ChangeNotifier` classes, initialized via `MultiProvider` at the app root for efficient, selective widget rebuilding.

### Data Flow

```
User Action → Screen Widget → Provider/Service → External API/Firebase → State Update → UI Rebuild
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.10.7+ (Dart) |
| **Auth** | Firebase Authentication |
| **Database** | Cloud Firestore (NoSQL) |
| **Code Execution** | Wandbox REST API |
| **Push Notifications** | Firebase Cloud Messaging |
| **Local Notifications** | flutter_local_notifications |
| **State Management** | Provider (ChangeNotifier) |
| **Local Storage** | SharedPreferences, Hive |
| **HTTP** | http package |
| **Utilities** | qr_flutter, url_launcher, share_plus, intl, uuid |

---

## 📋 Prerequisites

- **Flutter SDK** ≥ 3.10.7
- **Dart SDK** (compatible version, bundled with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Firebase project** configured with Authentication, Firestore, and Cloud Messaging
- **Android device/emulator** running Android 5.0 (API 21) or higher
- Active internet connection (for code execution and Firebase services)

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/krishna190806/CodeXecute.git
cd CodeXecute
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable **Email/Password** authentication
3. Create a **Cloud Firestore** database
4. Enable **Firebase Cloud Messaging**
5. Download `google-services.json` and place it in `android/app/`
6. Update `lib/firebase_options.dart` with your project configuration

### 4. Run the App

```bash
# Check your setup
flutter doctor

# Run on connected device or emulator
flutter run

# Build APK
flutter build apk --release
```

---

## 📱 App Screens

| Screen | Description |
|--------|-------------|
| **Splash** | Animated branding with fade-in + scale animation while Firebase initializes |
| **Login** | Email/password auth with real-time validation and "Forgot Password" flow |
| **Register** | New account creation with display name, email validation, password confirmation |
| **Dashboard** | Central hub with 6 feature cards (Compiler, Snippets, History, Profile, Settings, Notifications) + navigation drawer |
| **Compiler** | Full-featured code editor with language selector, stdin input, color-coded output, and action buttons |
| **Snippets** | Browse, save, and manage code snippets with pre-built templates |
| **History** | Review past executions with code, output, duration, and status |
| **Profile** | User info, appearance settings, editor preferences, and logout |
| **Notifications** | Test local/scheduled/push notifications with FCM token display |
| **Language Info** | Educational content about Python, Java, and C++ |

---

## 🗄️ Database Schema

### Cloud Firestore

**`notes` collection**

| Field | Type | Description |
|-------|------|-------------|
| `title` | String | Note title |
| `description` | String | Note content |
| `date` | String | Creation timestamp |
| `status` | Boolean | Completion status |

**`tasks` collection**

| Field | Type | Description |
|-------|------|-------------|
| `title` | String | Task title |
| `description` | String | Task details |
| `isCompleted` | Boolean | Completion flag |
| `date` | String | Creation timestamp |

### Local Storage (SharedPreferences)

`isLoggedIn`, `userEmail`, `userId`, `themeMode`, `fontSize`, `syntaxTheme`, `keyboardShortcuts`, `autoFormat`, `offlineMode`

---

## 🎨 Design

- **Theme**: Premium dark mode with deep background (`#0F0F13`), surface (`#1E1E24`), and indigo accent (`#6366F1`)
- **Design System**: Material Design 3
- **Animations**: Fade, scale, and elastic-out transitions on splash; smooth page transitions throughout
- **Typography**: Clean hierarchy with proper contrast ratios
- **Accessibility**: 48dp minimum touch targets, descriptive labels, light/dark/system theme support

---

## 🔮 Future Enhancements

- 🤖 **AI-Powered Code Suggestions** — Integration with Gemini/Codex for auto-completion and error explanations
- 🌍 **More Languages** — JavaScript, TypeScript, Go, Rust, Kotlin, Swift, Ruby, PHP
- 🎨 **Custom Themes** — Solarized Dark, Dracula, Nord, Material Ocean, and user-created themes
- 📴 **Full Offline Support** — Queue code execution for when connectivity is restored
- 💬 **Real-Time Collaboration** — Chat, shared editing, and community snippet library
- 💳 **Premium Features** — Subscription model with increased limits and ad-free experience
- 🐛 **Integrated Debugger** — Step-through debugging, breakpoints, and variable inspection
- 🏆 **Gamification** — Coding challenges, daily problems, achievement badges, and learning tracks

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is developed as part of the **Mobile Application Development (MAD)** course — 6th Semester, Academic Year 2025–2026.

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) — Google's UI toolkit for cross-platform development
- [Firebase](https://firebase.google.com/) — Backend-as-a-Service for auth, database, and messaging
- [Wandbox](https://wandbox.org/) — Free online compiler API supporting 30+ languages
- [Provider](https://pub.dev/packages/provider) — Recommended state management for Flutter
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) — Free fake REST API for testing

---

<div align="center">

**Built with ❤️ using Flutter**

⭐ Star this repo if you found it useful!

</div>
