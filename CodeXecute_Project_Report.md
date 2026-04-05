# CodeXecute Mobile Application

## Project Report

---

## COVER PAGE

---

**Project Title:** CodeXecute – A Multi-Language Mobile Code Execution Platform

**Technology Used:** Flutter (Dart), Firebase Authentication, Cloud Firestore, REST API Integration (Wandbox API)

**Student Name:** ____________________

**Roll Number:** ____________________

**Subject Name:** Mobile Application Development (MAD)

**College Name:** ____________________

**Semester:** 6th Semester

**Academic Year:** 2025–2026

---

\newpage

## CERTIFICATE

---

This is to certify that the project titled **"CodeXecute – A Multi-Language Mobile Code Execution Platform"** has been successfully completed by **[Student Name]**, bearing Roll Number **[Roll Number]**, in partial fulfillment of the requirements for the subject **Mobile Application Development (MAD)** during the **6th Semester** of the **Academic Year 2025–2026**.

This project has been carried out under our guidance and supervision. The work presented in this report is original and has not been submitted elsewhere for any other purpose. The student has demonstrated satisfactory knowledge and skill in mobile application development using the Flutter framework, Firebase services, and REST API integration throughout the course of this project.

&nbsp;

**Date:** ____________________

&nbsp;

**Guide/Faculty Signature:** ____________________

**Name of Guide:** ____________________

**Designation:** ____________________

&nbsp;

**Head of Department Signature:** ____________________

**Name:** ____________________

**Designation:** ____________________

&nbsp;

**College Seal**

---

\newpage

## ACKNOWLEDGMENT

---

I would like to express my heartfelt gratitude to everyone who supported me throughout the development of the CodeXecute mobile application project. This project would not have been possible without the guidance, encouragement, and assistance of several individuals.

First and foremost, I would like to extend my sincere thanks to my project guide, **[Faculty Name]**, for their invaluable guidance and mentorship during the entire course of this project. Their expert advice on mobile application architecture, user interface design, and best practices in Flutter development helped me shape this project into a well-rounded application. They consistently provided constructive feedback that improved both the technical quality and the overall presentation of the work.

I am deeply grateful to the **Head of the Department**, **[HOD Name]**, for providing access to the necessary resources and a supportive academic environment. Their encouragement to explore modern mobile technologies gave me the confidence to work with cutting-edge frameworks like Flutter and Firebase.

I also wish to thank the **Principal** of **[College Name]** for fostering an institution that encourages practical learning and hands-on project work. The infrastructure and facilities provided by the college were instrumental in the completion of this project.

My sincere appreciation goes to the entire **faculty members** of the Computer Science / Information Technology department, who laid the foundational knowledge in programming, database management, and software engineering during previous semesters. Their teachings formed the base upon which this project was built.

I would also like to acknowledge the open-source community, especially the developers behind the **Flutter framework**, **Firebase platform**, and the **Wandbox online compiler API**. The extensive documentation, community forums, and freely available tools made it possible to develop a feature-rich application within the project timeline.

Finally, I would like to thank my **family and friends** for their constant support, patience, and motivation throughout this journey. Their belief in my abilities kept me going during the challenging phases of development and debugging.

This project has been an enriching experience that enhanced my understanding of mobile application development, state management, API integration, and cloud-based backend services, and I am truly grateful for every contribution that made it possible.

---

\newpage

## TABLE OF CONTENTS

---

1. Abstract
2. Introduction
3. Overall Description
4. Functional Requirements
5. Non-Functional Requirements
6. System Design and Architecture
7. Database Design
8. User Interface Design
9. Implementation Details
10. Testing
11. Future Enhancements
12. Conclusion
13. References

---

\newpage

## 1. ABSTRACT

---

CodeXecute is a modern, feature-rich mobile application developed using the Flutter framework that serves as a comprehensive platform for writing, compiling, and executing code in multiple programming languages directly from a mobile device. The application is designed to address the growing need among students, beginner programmers, and coding enthusiasts for a convenient, portable, and user-friendly code execution environment that eliminates the requirement for desktop-based Integrated Development Environments (IDEs).

The application supports three widely-used programming languages: Python, Java, and C++. Users can write code using an intuitive in-app code editor, provide custom standard input (stdin) data, and execute their programs in real time through integration with the Wandbox online compiler REST API. The execution results, including program output, compiler errors, and runtime diagnostics, are displayed within the application with clear formatting and color-coded indicators for success and error states.

Beyond basic code execution, CodeXecute incorporates a robust set of features that make it a well-rounded productivity tool for programmers. It includes Firebase Authentication for secure user login and registration, Cloud Firestore for persistent data storage of notes and tasks with full CRUD (Create, Read, Update, Delete) operations, a code snippet management system for saving and organizing frequently used code templates, execution history tracking, and a comprehensive notification system supporting both local and push notifications via Firebase Cloud Messaging (FCM).

The application is built using the Provider state management pattern, ensuring efficient data flow and UI reactivity across all screens. It follows a modular architecture with clearly separated concerns through dedicated service classes, provider classes, model classes, and screen widgets. The user interface features a premium dark theme with Material Design 3 aesthetics, smooth animations, gradient backgrounds, and responsive layouts that adapt to different screen sizes.

Key technologies employed include Flutter and Dart for cross-platform mobile development, Firebase Core, Firebase Authentication, and Cloud Firestore for backend services, Firebase Messaging and Flutter Local Notifications for push and scheduled notifications, the HTTP package for REST API communication, SharedPreferences and Hive for local data persistence, and several utility packages including QR code generation, URL launching, and social sharing capabilities.

This project demonstrates practical implementation of essential mobile application development concepts including user authentication and session management, real-time database operations, RESTful API integration, local and remote notification handling, state management patterns, and modern UI/UX design principles. The resulting application provides genuine utility to its target users while serving as a comprehensive showcase of mobile development skills and best practices.

---

\newpage

## 2. INTRODUCTION

---

### 2.1 What Are Mobile Applications?

Mobile applications, commonly referred to as apps, are software programs specifically designed and developed to run on mobile devices such as smartphones and tablets. Unlike traditional desktop software that requires a personal computer, mobile applications leverage the unique capabilities of portable devices, including touchscreens, cameras, GPS sensors, accelerometers, and persistent internet connectivity, to deliver rich and interactive user experiences.

Mobile applications have evolved significantly since the introduction of the first smartphone app stores in 2008. Today, they encompass virtually every domain of human activity, from communication and social networking to banking, healthcare, education, entertainment, and professional productivity. The global mobile application market has grown into a multi-billion-dollar industry, with millions of applications available across major platforms such as Google Play Store for Android devices and the Apple App Store for iOS devices.

From a technical perspective, mobile applications can be broadly categorized into three types. Native applications are built using platform-specific programming languages and tools, such as Kotlin or Java for Android and Swift or Objective-C for iOS. These applications offer the best performance and access to all device features but require separate codebases for each platform. Web applications are essentially websites optimized for mobile browsers, offering cross-platform compatibility but limited access to device hardware. Hybrid or cross-platform applications, which represent the approach adopted for this project, use frameworks like Flutter, React Native, or Xamarin to write a single codebase that compiles into native applications for multiple platforms. This approach balances development efficiency with near-native performance and user experience.

### 2.2 Importance of Mobile Applications in Real Life

Mobile applications have become an indispensable part of modern life, fundamentally transforming how individuals interact with technology, access information, and perform daily tasks. Their importance can be understood across several dimensions.

In the field of education, mobile applications have democratized access to learning resources. Students can access course materials, watch educational videos, practice coding exercises, and collaborate with peers from anywhere at any time. Applications like Duolingo, Khan Academy, and various coding platforms have made high-quality education accessible to millions of users worldwide, regardless of their geographical location or economic background.

In the professional and productivity domain, mobile applications enable remote work, project management, team collaboration, and real-time communication. Tools built as mobile apps have become essential for businesses of all sizes, allowing employees to stay productive while on the move. The COVID-19 pandemic further accelerated this trend, making mobile productivity tools a necessity rather than a convenience.

For the programming and software development community specifically, mobile applications that provide code editing and execution capabilities address a significant gap. Traditionally, writing and running code required access to a computer with an installed development environment. Mobile code execution platforms, such as the one developed in this project, enable programmers to practice coding, test algorithms, and experiment with different programming languages using only their smartphones. This is particularly valuable for students who may not always have access to a computer but want to continue learning and practicing programming.

### 2.3 Overview of CodeXecute Application

CodeXecute is a mobile application purpose-built for programmers, students, and coding enthusiasts who need a portable, reliable, and feature-rich platform for writing and executing code on the go. The name "CodeXecute" is a combination of "Code" and "Execute," reflecting the application's core functionality of enabling users to write code and execute it instantly from their mobile devices.

The application was conceived to solve a practical problem faced by programming students: the inability to practice coding when away from their computers. By providing a fully functional code editor with support for Python, Java, and C++ along with real-time code execution powered by a cloud-based compiler API, CodeXecute eliminates the dependency on desktop development environments for basic to intermediate coding tasks.

Beyond its primary code execution feature, CodeXecute includes a comprehensive suite of productivity tools. Users can save their code as named snippets for future reference, track their execution history to review past programs and outputs, manage notes and tasks using Firebase Firestore, customize their editor preferences including font size and syntax highlighting themes, and receive notifications for practice reminders and task deadlines. The application also includes a dedicated language information section where users can learn about the features, syntax, and best practices of each supported programming language.

The user interface of CodeXecute follows a modern, dark-themed aesthetic with a deep background color scheme accented by indigo highlights, providing a visually comfortable experience that is especially suited for code editing. The design incorporates Material Design 3 principles, smooth transitions, gradient decorations, and thoughtfully organized navigation to ensure an intuitive and pleasant user experience.

### 2.4 Technologies Used

The development of CodeXecute leverages a carefully selected technology stack that combines modern frameworks, cloud services, and third-party APIs to deliver a robust and scalable mobile application.

**Flutter (Dart):** Flutter is Google's open-source UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. Written in the Dart programming language, Flutter provides a rich set of pre-built widgets, a powerful rendering engine, and hot-reload capability for rapid development. For this project, Flutter serves as the primary development framework, providing the foundation for the application's user interface, navigation, animations, and business logic.

**Firebase:** Firebase is Google's comprehensive Backend-as-a-Service (BaaS) platform that provides a suite of cloud-based tools for mobile and web application development. In CodeXecute, three Firebase services are utilized: Firebase Authentication for secure user login, registration, and password reset; Cloud Firestore for storing user notes, tasks, and profile data in a NoSQL document database; and Firebase Cloud Messaging (FCM) for delivering push notifications to users.

**REST API Integration (Wandbox API):** The Wandbox API is a free online compiler API that supports over 30 programming languages. CodeXecute integrates with this API to send user-written code to remote servers for compilation and execution, then retrieves and displays the results within the application. This approach eliminates the need for local compiler installation and enables code execution in a mobile environment.

**Provider State Management:** Provider is the recommended state management solution for Flutter applications. It follows the Observer pattern, allowing widgets to listen to changes in application state and rebuild automatically when data changes. CodeXecute uses multiple providers including AuthProvider, TaskProvider, SnippetProvider, SettingsProvider, and HistoryProvider to manage different aspects of application state.

**Additional Packages:** The application incorporates several supplementary packages including SharedPreferences for local key-value storage, Hive for local database storage, flutter_local_notifications for scheduled notifications, http for REST API communication, qr_flutter for QR code generation, url_launcher for opening external links, share_plus for social sharing functionality, intl for date formatting, and uuid for generating unique identifiers.

---

\newpage

## 3. OVERALL DESCRIPTION

---

### 3.1 Product Perspective

CodeXecute is a standalone mobile application that serves as a lightweight, portable code execution environment and programming productivity tool. While it operates independently as a self-contained application, it relies on external cloud services for key functionalities such as user authentication, data persistence, push notifications, and code compilation.

The application sits at the intersection of educational technology and developer tooling. Unlike full-featured desktop IDEs such as Visual Studio Code, IntelliJ IDEA, or Android Studio, CodeXecute is not intended to replace professional development environments. Instead, it fills a specific niche by providing a mobile-first experience that allows users to quickly write, test, and execute code snippets in Python, Java, or C++ without the overhead of setting up a complete development environment. This makes it particularly suitable for students who want to practice coding during commutes, study breaks, or other situations where a computer is not readily available.

From an architectural standpoint, the application follows a client-server model. The Flutter application serves as the client, handling all user interface rendering, local state management, and user interactions. Firebase services act as the primary backend, providing authentication, database, and messaging capabilities. The Wandbox API serves as a specialized external service for code compilation and execution. This architecture ensures that the application can leverage powerful cloud-based services while maintaining a lightweight client-side footprint.

### 3.2 Product Features

The CodeXecute application encompasses the following major feature areas:

**Multi-Language Code Execution:** Users can write and execute code in Python, Java, and C++ using a built-in code editor. The code is compiled and executed via the Wandbox API, with results displayed in real time. The editor supports custom standard input (stdin) for interactive programs.

**Code Snippet Management:** Users can save their code as named snippets, organize them by programming language, and retrieve them later. The application provides pre-built code templates and snippets for common programming patterns in each supported language.

**Execution History:** Every code execution is automatically logged with details including the source code, programming language, output, execution time, and success or failure status. Users can review their execution history to track their progress and revisit previous programs.

**User Authentication:** Secure email-based registration and login using Firebase Authentication, with session persistence via SharedPreferences. The application supports password reset via email for account recovery.

**Notes and Tasks Management:** Full CRUD operations for managing notes and tasks, powered by Cloud Firestore. Users can create, read, update, and delete notes and tasks, with real-time synchronization across sessions.

**Notifications:** Comprehensive notification support including instant local notifications, scheduled notifications with timezone awareness, task reminder notifications, daily practice reminders, and Firebase Cloud Messaging for push notifications.

**User Profile and Settings:** Profile management with display name and email, along with configurable settings for theme mode (light, dark, system), editor font size, syntax highlighting theme, keyboard shortcuts, auto-formatting, and offline mode.

**API Data Display:** Integration with the JSONPlaceholder REST API for fetching and displaying posts data, demonstrating standard API consumption patterns with loading states, error handling, and pull-to-refresh functionality.

### 3.3 User Classes and Characteristics

The application serves two primary user classes:

**End Users (Students and Programmers):** These are the primary users of the application. They include programming students who need a portable coding environment for practice, beginner programmers who are learning Python, Java, or C++, and coding enthusiasts who want to quickly test code snippets on their mobile devices. These users interact with all features of the application including code execution, snippet management, history tracking, and notification settings.

**Administrators (Firebase Console):** Administrative functions are handled through the Firebase Console, which is external to the mobile application. Administrators can manage user accounts, monitor database usage, send push notifications to all users or specific devices, and configure Cloud Messaging campaigns. This separation of administrative functionality from the mobile application ensures security and simplicity.

### 3.4 Operating Environment

CodeXecute is primarily designed as an Android mobile application, though the Flutter framework enables potential deployment to iOS, web, and desktop platforms with minimal modifications. The minimum requirements are as follows:

- **Platform:** Android 5.0 (API level 21) or higher
- **Network:** Active internet connection required for code execution, authentication, and Firestore synchronization
- **Storage:** Approximately 50 MB of storage space for the application and local data
- **RAM:** Minimum 2 GB of device RAM recommended for smooth operation
- **Development SDK:** Flutter SDK 3.10.7 or higher, Dart SDK compatible version

---

\newpage

## 4. FUNCTIONAL REQUIREMENTS

---

### 4.1 User Login and Authentication

The authentication system is a foundational component of CodeXecute, ensuring that each user has a secure, personalized experience within the application. The system is built on Firebase Authentication and managed through a dedicated AuthProvider class that implements the ChangeNotifier pattern.

**Registration Process:** New users can create an account by providing their email address, a password (minimum 6 characters), and a display name. The registration form includes comprehensive validation with real-time feedback. Email addresses are validated for proper format, passwords are checked for minimum length requirements, and password confirmation is verified for match. Upon successful registration, the user's display name is stored with their Firebase profile, and they are automatically logged in and redirected to the Dashboard screen.

**Login Process:** Existing users authenticate using their email and password combination. The login form features real-time input validation, where the login button remains disabled until both the email field is non-empty and the password meets the minimum length requirement. During authentication, a loading indicator is displayed to provide visual feedback. Upon successful login, the user's session state is persisted to SharedPreferences, enabling automatic login on subsequent application launches.

**Session Persistence:** The application implements session persistence using SharedPreferences. When a user logs in, their login state, email, and user ID are stored locally. On application startup, the AuthProvider checks for a stored session and attempts to restore the authentication state. This ensures that users remain logged in across application restarts without needing to re-enter their credentials.

**Password Reset:** Users who forget their password can initiate a password reset by providing their registered email address. The application sends a password reset email through Firebase Authentication, allowing users to create a new password via a secure link.

**Logout:** The logout process clears both the Firebase authentication state and locally stored session data, ensuring a complete sign-out. After logout, users are redirected to the Login screen, and all navigation history is cleared to prevent unauthorized access via the back button.

**Error Handling:** The authentication system provides user-friendly error messages for common scenarios including invalid email format, wrong password, non-existent account, email already in use, weak password, disabled account, and rate limiting due to too many failed attempts.

### 4.2 Navigation Between Screens

CodeXecute implements a comprehensive navigation system using Flutter's named routing mechanism combined with Material page transitions. The application defines the following routes: splash, login, dashboard, register, settings, profile, notifications, posts, compiler, and language_info.

The navigation flow follows a logical hierarchy. The Splash Screen serves as the entry point, displaying app branding while Firebase initializes and authentication state is determined. Based on the authentication result, users are directed either to the Login Screen or the Dashboard. The Dashboard serves as the central hub, providing access to all major features through a grid of feature cards and a navigation drawer.

The navigation drawer provides an alternative navigation mechanism, displaying the user's profile information at the top followed by links to all major sections: Dashboard, Compiler, Snippets, History, Profile, Settings, Notifications, and a Logout option. This dual navigation approach via feature cards and navigation drawer ensures that all features are easily accessible regardless of the user's location within the application.

### 4.3 CRUD Operations (Notes and Tasks)

The application implements full Create, Read, Update, and Delete operations for both notes and tasks, backed by Cloud Firestore as the persistent data store. These operations are encapsulated in a dedicated FirestoreService class that provides a clean API for data manipulation.

**Create Operation:** Users can add new notes or tasks by providing a title and description. When a note is created, the system automatically records the creation timestamp and sets a default status of incomplete. For tasks, an isCompleted flag is initialized to false. The data is stored in the respective Firestore collection (notes or tasks) with an auto-generated document ID.

**Read Operation:** Notes and tasks are retrieved from Firestore using real-time stream-based queries. The getNotesStream() and getTasksStream() methods return Stream objects that emit QuerySnapshot updates whenever the underlying data changes. This ensures that the UI automatically reflects any additions, modifications, or deletions in real time. Data is ordered by date in descending order, displaying the most recent entries first.

**Update Operation:** Users can modify the title and description of existing notes and tasks. For notes, an additional toggle operation allows users to change the completion status. For tasks, the update operation can modify the title, description, and completion status simultaneously. All updates are performed using the Firestore document ID as the unique identifier.

**Delete Operation:** Users can remove notes and tasks from the database. Deletion is performed by referencing the document ID, and the operation is permanent. The UI updates automatically through the stream-based data retrieval mechanism.

The TaskProvider class wraps the FirestoreService and adds additional state management logic, including loading indicators, error handling, and optimistic UI updates. It serves as the intermediary between the UI layer and the data layer, following the recommended Flutter architecture pattern.

### 4.4 API Data Fetching and Display

CodeXecute demonstrates REST API integration through two distinct implementations: the Wandbox Compiler API for code execution and the JSONPlaceholder API for displaying sample post data.

**Wandbox Compiler API Integration:** The CompilerService class manages all communication with the Wandbox API (https://wandbox.org/api/compile.json). When a user submits code for execution, the service constructs a JSON request containing the compiler identifier, source code, and standard input data. The request is sent as an HTTP POST with a 30-second timeout. The response is parsed to extract program output, compiler errors, and runtime errors, which are then formatted and displayed to the user with appropriate color coding: green for successful output and red for errors. The service also includes error explanation functionality through the CompilerUtils class, which provides diagnostic messages to help users understand compilation and runtime errors.

**JSONPlaceholder API Integration:** The PostApiService class demonstrates standard REST API consumption by fetching posts from the JSONPlaceholder API (https://jsonplaceholder.typicode.com/posts). The PostsScreen implements FutureBuilder to handle asynchronous data loading with three states: loading (CircularProgressIndicator), error (error message with retry button), and success (scrollable list of post cards). The screen also supports pull-to-refresh functionality through the RefreshIndicator widget.

### 4.5 Notifications (Local and Push)

The notification system in CodeXecute is comprehensive, supporting both local notifications and Firebase Cloud Messaging push notifications. The implementation is managed through a singleton NotificationService class.

**Local Notifications:** The application uses the flutter_local_notifications package to display instant and scheduled notifications. Instant notifications are shown immediately when triggered by user actions, such as tapping a notification button on the Notifications screen. Scheduled notifications use timezone-aware scheduling through the timezone package, allowing the application to trigger notifications at specific future times. The notification system creates a dedicated Android notification channel named "CodeXecute Notifications" with high importance to ensure visibility.

**Push Notifications (FCM):** Firebase Cloud Messaging is configured to handle notifications in three states: foreground (when the app is open and active), background (when the app is minimized), and terminated (when the app is completely closed). Foreground messages are intercepted and displayed as local notifications to ensure the user sees them. Background and terminated message handling is implemented through a top-level background handler function as required by the Firebase Messaging plugin.

**Task-Specific Notifications:** The system provides specialized notification methods for task management scenarios: scheduleTaskReminder (sends a reminder one hour before a task's due date), scheduleDailyReminder (recurring daily notification at a specified time using DateTimeComponents.time), notifyTaskCompleted (instant celebration notification when a task is marked complete), and notifyTaskUpdate (notification for changes to task details).

**Notification Tap Navigation:** When a user taps a notification, the application navigates to the appropriate screen based on the notification payload. Task-related notifications navigate to the tasks screen with the specific task ID, daily practice reminders navigate to the dashboard, and app update notifications navigate to the settings screen.

### 4.6 Advanced Features

**Multi-Language Code Compiler:** The code compiler is the centerpiece feature of CodeXecute. It supports Python (CPython 3.14), Java (OpenJDK 22+), and C++ (GCC 13.2.0). The compiler screen provides a full-featured code editor with syntax-appropriate coloring, code templates for each language, code formatting capabilities, clipboard integration for copying code, and the ability to save frequently used code as named snippets. Each language has a distinct visual identity with unique color schemes: blue and yellow for Python, red and orange for Java, and blue and cyan for C++.

**Code Snippet Library:** Users can save, organize, and manage code snippets across all supported languages. The pre-built snippet library includes common programming patterns such as Hello World programs, input/output operations, loops, conditionals, data structure operations, and algorithm implementations. User-saved snippets include metadata such as title, description, language, creation date, favorite status, tags, and usage count.

**Execution History Tracking:** Every code execution is automatically recorded with comprehensive metadata including the source code, selected language, execution output, execution time in milliseconds, success or failure status, any error messages, and stdin input data. Users can browse their execution history to review past programs and their results.

---

\newpage

## 5. NON-FUNCTIONAL REQUIREMENTS

---

### 5.1 Performance

The CodeXecute application is designed with performance as a primary consideration at every level of the architecture. The Flutter framework's widget tree architecture and the Dart language's ahead-of-time (AOT) compilation ensure that the application delivers smooth 60 frames-per-second rendering performance on modern Android devices.

The Provider state management pattern contributes to performance optimization by implementing selective widget rebuilding. Rather than rebuilding the entire widget tree when data changes, only the widgets that depend on the modified data are reconstructed. This is achieved through the Consumer and Selector widgets, which listen to specific providers and rebuild only when relevant state changes occur.

Network operations, particularly code compilation via the Wandbox API, are handled asynchronously to prevent UI blocking. The application implements a 30-second timeout for compilation requests, ensuring that users are not left waiting indefinitely in case of network issues or complex code that takes too long to compile. Loading state indicators provide visual feedback during all asynchronous operations.

Local data caching through SharedPreferences and Hive ensures that frequently accessed data, such as user preferences, saved snippets, and execution history, is available instantly without requiring network requests. This hybrid approach of combining local caching with cloud synchronization provides the best balance of data availability and responsiveness.

### 5.2 Security

Security is implemented across multiple layers of the application. Firebase Authentication provides industry-standard security for user credentials, including password hashing, secure token management, and protection against common attack vectors such as brute force attempts (with automatic rate limiting after too many failed login attempts).

User session data stored in SharedPreferences is limited to non-sensitive information such as login state and user email. Sensitive authentication tokens are managed entirely by the Firebase SDK, which handles secure storage and automatic token refresh.

All network communication, including Firebase operations and Wandbox API requests, is conducted over HTTPS, ensuring encryption of data in transit. Cloud Firestore security rules can be configured to restrict data access based on user authentication status, ensuring that users can only access their own data.

The application implements proper input validation on all user-facing forms, preventing injection attacks and malformed data from reaching the backend services. Error messages are designed to be informative without exposing sensitive system information.

### 5.3 Usability

The user interface of CodeXecute follows Material Design 3 guidelines, providing a familiar and intuitive experience for Android users. The dark theme design, featuring a deep background color (hex 0xFF0F0F13) with a slightly lighter surface color (hex 0xFF1E1E24) and indigo accent color (hex 0xFF6366F1), is specifically chosen for comfortable code editing and extended use.

The application provides clear visual feedback for all user actions through snackbar notifications, loading indicators, color-coded output displays, and animated transitions. Form fields include hint text, labels, and validation messages that guide users through data entry. The navigation structure is straightforward, with the dashboard providing a grid-based overview of all available features.

Accessibility considerations include proper text contrast ratios, sufficiently sized touch targets (minimum 48dp for interactive elements), and descriptive labels on all buttons and icons. The application supports both light and dark themes, with an additional system-default option that follows the device's theme setting.

### 5.4 Scalability

The application architecture supports scalability through several design decisions. The use of Cloud Firestore as the primary database provides automatic horizontal scaling, as Firestore can handle millions of concurrent connections and billions of documents without requiring manual infrastructure management.

The Provider-based state management architecture allows for easy addition of new features and data sources. New providers can be added to the MultiProvider configuration without modifying existing code, following the open-closed principle of software design.

The modular service layer (CompilerService, FirestoreService, NotificationService, PostApiService) ensures that individual services can be updated or replaced without affecting other parts of the application. For example, the Wandbox API could be replaced with an alternative compiler service by modifying only the CompilerService class.

### 5.5 Reliability

Reliability is ensured through comprehensive error handling at every level of the application. All Firebase operations are wrapped in try-catch blocks with specific error type handling and user-friendly error messages. Network requests include timeout mechanisms and graceful degradation when services are unavailable.

The authentication system includes session persistence, ensuring that temporary network disruptions do not force users to re-authenticate. Cloud Firestore's offline persistence capability allows users to continue accessing cached data even when the network connection is intermittent.

The notification system includes fallback mechanisms for different platform capabilities, with web and mobile platforms handled differently to avoid unsupported feature calls. The code compilation service handles various error scenarios including network timeouts, server errors, compilation failures, and runtime exceptions, providing appropriate feedback for each situation.

---

\newpage

## 6. SYSTEM DESIGN AND ARCHITECTURE

---

### 6.1 Architecture Overview

CodeXecute follows a layered architecture pattern that separates concerns across distinct layers, each with a well-defined responsibility. This architecture promotes maintainability, testability, and code reuse.

**Presentation Layer (Screens and Widgets):** This layer contains all user interface code, organized into individual screen files within the screens directory and reusable widgets within the widgets directory. Each screen is implemented as either a StatelessWidget or StatefulWidget depending on whether it manages local state. Screens consume data from providers using Consumer widgets and delegate business logic to the service and provider layers.

**State Management Layer (Providers):** The provider layer serves as the intermediary between the presentation layer and the data layer. It manages application state, exposes it to the UI, and handles state mutations in response to user actions. The application defines six providers: AuthProvider for authentication state, TaskProvider for notes and tasks data, SnippetProvider for code snippet management, SettingsProvider for user preferences, HistoryProvider for execution history, and CodeSnippetsProvider for pre-built code templates.

**Service Layer (Services):** The service layer encapsulates all external interactions and business logic that is independent of the UI framework. It includes CompilerService for Wandbox API communication, FirestoreService for Cloud Firestore CRUD operations, NotificationService for local and push notification management, PostApiService for JSONPlaceholder API integration, and CompilerUtils for code formatting and error analysis utilities.

**Data Layer (Models):** The model layer defines the data structures used throughout the application. It includes CodeSnippet (representing a saved code snippet with fields for id, title, description, language, code, isFavorite, createdAt, updatedAt, tags, and usageCount), CodeExecution (representing a code execution record), and Post (representing an API post with id, title, and body). Each model includes serialization methods (toJson and fromJson) for converting between Dart objects and JSON format.

### 6.2 Data Flow

The data flow in CodeXecute follows a unidirectional pattern consistent with the Provider state management approach:

1. **User Interaction:** The user performs an action on a screen widget, such as tapping the "Run Code" button on the Compiler screen.

2. **Provider Invocation:** The screen widget calls a method on the appropriate provider, which updates its internal state and notifies listeners. For code execution, the CompilerScreen directly invokes the CompilerService.

3. **Service Execution:** The provider or screen delegates the actual work to the relevant service class. The CompilerService constructs an HTTP POST request with the code, compiler identifier, and stdin data, and sends it to the Wandbox API.

4. **External Communication:** The service communicates with external services (Firebase, Wandbox API, JSONPlaceholder API) over HTTPS, sending requests and receiving responses.

5. **State Update:** Upon receiving a response, the service returns the processed data to the calling code. The provider updates its state and calls notifyListeners(), triggering a rebuild of all listening widgets.

6. **UI Update:** The Consumer widgets in the presentation layer detect the state change and rebuild with the updated data, displaying the new information to the user.

### 6.3 Navigation Flow

The navigation flow of CodeXecute follows a structured hierarchy from application launch to feature access:

**Application Launch Flow:**
Splash Screen → [Authentication Check] → Login Screen (if not authenticated) OR Dashboard (if authenticated)

**Authentication Flow:**
Login Screen → Dashboard (on successful login)
Login Screen → Registration Screen → Dashboard (on successful registration)
Login Screen → Forgot Password Screen → Login Screen (after password reset email sent)

**Main Application Flow:**
Dashboard → Compiler Screen → (Snippets List / History / Settings Detail / Language Info)
Dashboard → Snippets List Screen
Dashboard → History Screen
Dashboard → Profile Screen (with embedded settings)
Dashboard → Settings Detail Screen
Dashboard → Notifications Screen

**Logout Flow:**
Dashboard (Navigation Drawer) → Logout → Login Screen (with cleared navigation stack)

---

\newpage

## 7. DATABASE DESIGN

---

### 7.1 Firebase Firestore Structure

CodeXecute uses Cloud Firestore, a flexible, scalable NoSQL cloud database, as its primary persistent data store for server-side data. Firestore organizes data into collections, which contain documents, which in turn contain fields with values. The database structure is designed to support efficient querying, real-time synchronization, and straightforward data management.

### 7.2 Collections and Document Structure

**Collection: notes**

This collection stores user-created notes. Each document represents a single note with the following fields:

| Field | Data Type | Description |
|-------|-----------|-------------|
| title | String | The title of the note |
| description | String | Detailed content of the note |
| date | String | Timestamp of creation (DateTime.now().toString()) |
| status | Boolean | Completion status (default: false) |

The notes collection supports ordered retrieval by date in descending order, ensuring that the most recently created notes appear first in the list view.

**Collection: tasks**

This collection stores user-created tasks with the following document structure:

| Field | Data Type | Description |
|-------|-----------|-------------|
| title | String | The title of the task |
| description | String | Detailed description of the task |
| isCompleted | Boolean | Whether the task is completed (default: false) |
| date | String | Timestamp of creation (DateTime.now().toString()) |

**Collection: users (Firebase Authentication)**

User profile data is managed by Firebase Authentication and includes:

| Field | Data Type | Description |
|-------|-----------|-------------|
| uid | String | Unique user identifier (auto-generated) |
| email | String | User's email address |
| displayName | String | User's display name |
| photoURL | String (nullable) | URL to user's profile photo |

### 7.3 Local Data Storage

In addition to Cloud Firestore, CodeXecute uses local storage mechanisms for data that does not require cloud synchronization:

**SharedPreferences (Key-Value Storage):**
- isLoggedIn (Boolean): Stores login session state
- userEmail (String): Stores current user's email
- userId (String): Stores current user's Firebase UID
- themeMode (String): Stores user's theme preference (light/dark/auto)
- fontSize (double): Stores editor font size
- syntaxTheme (String): Stores selected syntax highlighting theme
- keyboardShortcuts (Boolean): Stores keyboard shortcuts enable/disable state
- autoFormat (Boolean): Stores auto-format enable/disable state
- offlineMode (Boolean): Stores offline mode preference

**Local Snippet Storage (JSON Serialization):**
Code snippets are stored locally using JSON serialization with the following structure per snippet:

| Field | Data Type | Description |
|-------|-----------|-------------|
| id | String | Unique identifier (timestamp-based) |
| title | String | User-defined snippet name |
| description | String | Brief description of the snippet |
| language | String | Programming language (Python/Java/C++) |
| code | String | The actual source code |
| isFavorite | Boolean | Whether marked as favorite |
| createdAt | String (ISO 8601) | Creation timestamp |
| updatedAt | String (ISO 8601, nullable) | Last modification timestamp |
| tags | String (nullable) | Comma-separated tags |
| usageCount | Integer | Number of times the snippet has been used |

### 7.4 Data Relationships

Although Firestore is a NoSQL database that does not enforce relational constraints, CodeXecute establishes logical relationships between data entities:

- Each user (identified by Firebase UID) owns their notes and tasks. In a production environment, Firestore security rules would restrict access to documents where the userId field matches the authenticated user's UID.
- Code snippets are associated with a programming language, enabling filtered retrieval by language type.
- Execution history records are linked to snippets through the language field and can be correlated with saved snippets by matching code content.
- Notification payloads contain task IDs that link notifications to specific tasks, enabling deep navigation from notification taps to relevant task details.

---

\newpage

## 8. USER INTERFACE DESIGN

---

### 8.1 Splash Screen

The Splash Screen is the first screen displayed when the application launches. It serves as a branding and loading screen while Firebase initializes and the authentication state is determined. The screen features a gradient background transitioning from the primary indigo color to a deeper shade, creating a visually appealing introduction to the application.

At the center of the screen, a circular white container holds the application's code icon (Icons.code) rendered in indigo. Below the icon, the application name "CodeXecute" is displayed in a bold, white, 32-pixel font with 2-pixel letter spacing and a subtle shadow effect. Beneath the name, the tagline "Navigate & Execute with State" is shown in a lighter, semi-transparent white font.

The screen incorporates entrance animations using an AnimationController with a 2-second duration. A fade animation (from 0.0 to 1.0 opacity) and a scale animation (from 0.8 to 1.0 scale with an elastic-out curve) combine to create a smooth, professional entrance effect. A circular progress indicator at the bottom provides visual feedback that the application is loading.

### 8.2 Login Screen

The Login Screen provides a secure and visually polished interface for user authentication. The screen is centered within a scrollable view to accommodate different screen sizes and keyboard visibility.

The top section displays the application icon (Icons.code, 80 pixels) in the primary color, followed by a "Welcome Back" heading and "Sign in to your account" subtitle. Below the branding, two styled text form fields are presented: an Email field with an email icon prefix and email-specific keyboard type, and a Password field with a lock icon prefix, obscured text by default, and a visibility toggle button.

Both fields feature a dark fill color (hex 0xFF1E1E24) with rounded corners (16-pixel radius), no visible border in the default state, a subtle white border with 5% opacity in the enabled state, and a 2-pixel primary color border in the focused state. Form validation provides real-time feedback: the email field checks for non-empty input and the presence of an '@' symbol, while the password field requires a minimum of 6 characters.

A "Forgot Password?" text button links to the password reset screen. The login button is styled with the primary indigo color, white text, 16-pixel border radius, and is disabled until both fields pass validation. During authentication, the button displays a compact circular progress indicator. Below the login button, a "Don't have an account? Create Account" text provides navigation to the registration screen.

### 8.3 Dashboard Screen

The Dashboard serves as the central hub of the application after successful authentication. It displays a personalized welcome message ("Welcome, [username]!") and a subtitle ("Manage your tasks and notes efficiently") at the top of the screen.

The main content area features a 2-column grid layout containing six feature cards: Compiler (blue), Snippets (cyan), History (orange), Profile (purple), Settings (indigo), and Notifications (red). Each card is implemented as a Container with a 20-pixel border radius, the current theme's card color, and a subtle border. Inside each card, a circular container with 15% opacity of the feature color holds the feature icon (30 pixels), followed by the feature title in 16-pixel, semi-bold text.

The app bar displays the "CodeXecute" title with bold white text and includes notification and profile action buttons. The profile button is rendered as a CircleAvatar with a person icon. A navigation drawer accessible via the hamburger menu provides an alternative navigation method, featuring a UserAccountsDrawerHeader with the user's name, email, and avatar, followed by list tiles for each feature and a logout option separated by a divider.

### 8.4 Compiler Screen

The Compiler Screen is the most feature-rich and visually complex screen in the application. It is divided into three main sections: Code Editor, Input (stdin), and Output.

The app bar features a gradient background that changes based on the selected programming language (blue-yellow for Python, red-orange for Java, blue-cyan for C++). It contains icon buttons for Snippets, History, Settings, and Language Info, along with a dropdown language selector styled with a semi-transparent white background and rounded borders.

The Code Editor section provides a large TextField (15 max lines, 12 min lines) with a monospace font (Courier, 13 pixels, 1.6 line height) on a dark background (hex 0xFF1E1E24). The editor container has a rounded border (16 pixels) with a language-colored accent border and a subtle glow shadow. Below the editor, two rows of action buttons provide Template, Format, Clear, Save Snippet, and Copy Code functionality, each styled with the respective feature color at 15% opacity.

The Input section provides a smaller TextField (3 max lines) for stdin data with an informational hint and a blue-themed border. The Output section displays execution results in a container with color-coded borders and shadows: green for successful execution and red for errors. The output text uses a Courier New font with appropriate color coding, and a success indicator ("=== Code Execution Successful ===") is appended to successful output.

A floating action button with the language color provides the primary "Run Code" action, displaying "Compiling..." with a circular progress indicator during execution.

### 8.5 Notifications Screen

The Notifications Screen provides a comprehensive testing interface for all notification types. It is organized into four sections: Local Notifications, Task Reminders, App Notifications, and FCM Setup.

Each notification type is presented as a card-based button with a colored circular avatar icon, title, subtitle, and a forward arrow indicator. The FCM section displays the device's FCM token in a monospace font within a bordered container, with a "Copy Token" button and a step-by-step guide for testing push notifications via the Firebase Console.

### 8.6 Profile Screen

The Profile Screen displays the user's avatar (CircleAvatar, 60-pixel radius), display name, and email at the top. Below the profile information, organized sections provide access to appearance settings (theme, font size, syntax theme), editor settings (keyboard shortcuts, auto-format), offline and storage settings (offline mode, clear cache), and about information (app version, keyboard shortcuts help). Each setting is presented as a ListTile with an appropriate icon, title, subtitle, and either a chevron for navigation or a Switch for toggle options. A red logout button is positioned at the bottom of the screen.

---

\newpage

## 9. IMPLEMENTATION DETAILS

---

### 9.1 State Management with Provider

The application uses the Provider package for state management, implementing the recommended Flutter architecture pattern. Five ChangeNotifier providers are initialized at the application root using MultiProvider:

- **AuthProvider:** Manages authentication state, including login, registration, logout, and session persistence. It listens to Firebase Auth state changes and notifies the UI accordingly.
- **TaskProvider:** Wraps the FirestoreService to manage notes and tasks data, providing loading states and error handling.
- **SnippetProvider:** Manages code snippet storage and retrieval using SharedPreferences with JSON serialization.
- **SettingsProvider:** Manages user preferences for theme mode, font size, syntax theme, keyboard shortcuts, auto-formatting, and offline mode.
- **HistoryProvider:** Tracks code execution history with metadata including code, language, output, execution time, and success status.

### 9.2 Code Compilation Pipeline

The code compilation feature follows a well-defined pipeline:

1. User writes code in the editor and optionally provides stdin input.
2. The CompilerScreen validates that the code is non-empty.
3. A Stopwatch is started to measure execution time.
4. The CompilerService.executeCode() method is called with the language, source code, and stdin data.
5. The service maps the user-friendly language name to the Wandbox compiler identifier.
6. For Java code, the public class modifier is stripped to prevent filename mismatch errors with Wandbox's default filename.
7. Stdin data is formatted with a trailing newline if not already present.
8. An HTTP POST request is sent to the Wandbox API with JSON body containing compiler, code, and stdin fields.
9. The response is parsed to extract program_output, compiler_error, and program_error fields.
10. Error explanations are generated using CompilerUtils.explainError() for any compile or runtime errors.
11. The result is returned to the screen, which updates the output display and records the execution in the HistoryProvider.

### 9.3 Firebase Integration

Firebase is initialized at application startup in the main() function with platform-specific options provided by the DefaultFirebaseOptions configuration class. The initialization is wrapped in a try-catch block to handle potential configuration errors gracefully.

Firebase Authentication is used through the FirebaseAuth.instance singleton, with auth state changes monitored via authStateChanges() stream. Cloud Firestore operations use the FirebaseFirestore.instance singleton with collection references for "notes" and "tasks". Firebase Cloud Messaging is configured with permission requests, token retrieval, and handlers for foreground, background, and terminated message states.

---

\newpage

## 10. TESTING

---

### 10.1 Testing Approach

The CodeXecute application was tested through a combination of manual testing, device testing, and API testing. Each feature was individually tested to ensure correct functionality, and integration testing was performed to verify that features work together seamlessly.

### 10.2 Test Scenarios

**Authentication Testing:** Tested successful login and registration with valid credentials, error handling for invalid email format, wrong password, non-existent account, and duplicate registration. Verified session persistence across application restarts and proper session clearing on logout.

**Code Execution Testing:** Tested code execution for all three languages with various program types, including simple output programs, programs requiring stdin input, programs with compilation errors, and programs with runtime errors. Verified timeout handling for long-running programs and proper error message display with diagnostics.

**CRUD Operations Testing:** Tested creation, reading, updating, and deletion of notes and tasks. Verified real-time UI updates through Firestore stream listeners and proper handling of concurrent operations.

**Notification Testing:** Tested instant notifications, scheduled notifications (10-second delay), daily recurring notifications, task reminders, and push notifications via Firebase Console. Verified notification tap navigation to appropriate screens.

**UI/UX Testing:** Tested responsive layout on different screen sizes, theme switching between light and dark modes, input validation on all forms, navigation flow between all screens, and proper loading state display during asynchronous operations.

---

\newpage

## 11. FUTURE ENHANCEMENTS

---

The CodeXecute application, while feature-complete for its current scope, has significant potential for future enhancements that would expand its functionality and user base.

**Artificial Intelligence Integration:** Integrating AI-powered code suggestions and auto-completion using services like OpenAI's Codex or Google's Gemini API would significantly enhance the coding experience. The AI could provide real-time code suggestions as users type, offer explanations for error messages in natural language, suggest optimizations for submitted code, and generate code from natural language descriptions. This feature would be particularly valuable for beginner programmers who are still learning syntax and programming patterns.

**Additional Programming Languages:** Expanding the supported languages beyond Python, Java, and C++ to include JavaScript, TypeScript, Go, Rust, Kotlin, Swift, Ruby, and PHP would make the application useful to a broader audience. The modular CompilerService architecture makes adding new languages relatively straightforward, as only the compiler mapping and language-specific templates need to be added.

**Dark Mode Enhancements and Custom Themes:** While the application already supports light and dark themes, future versions could offer multiple curated dark theme variants (such as Solarized Dark, Dracula, Nord, and Material Ocean) and allow users to create custom themes by selecting their preferred background, text, accent, and highlight colors.

**Offline Support:** Implementing comprehensive offline support using the Hive local database would allow users to write and save code even without an internet connection. The saved code could be queued for execution once connectivity is restored, and all Firestore data could be synchronized when the connection is re-established.

**Real-Time Chat and Collaboration System:** Adding a chat system would enable users to discuss code, share snippets, and seek help from other users. A real-time collaborative editing feature, similar to Google Docs, would allow multiple users to work on the same code simultaneously.

**Payment Integration and Premium Features:** Implementing in-app purchases or a subscription model could support advanced features such as increased code execution limits, priority compilation, access to premium code templates and algorithms, and ad-free experience. Integration with payment gateways like Razorpay or Stripe would enable monetization.

**Code Sharing and Social Features:** Enhancing the sharing functionality to include the ability to publish code snippets as public links, create a community-driven snippet library, and enable users to follow other programmers and view their shared code. Integration with GitHub for importing and exporting code repositories would further enhance the social coding experience.

**Integrated Debugging Tools:** Adding step-by-step debugging capabilities, breakpoint support, variable inspection, and memory profiling would transform CodeXecute from a simple code runner into a more capable development environment.

**Gamification and Learning Tracks:** Implementing coding challenges, daily coding problems, achievement badges, and structured learning tracks with progressive difficulty would engage users and encourage regular practice.

---

\newpage

## 12. CONCLUSION

---

### 12.1 Summary of Achievements

The CodeXecute mobile application project has been successfully designed, developed, and tested as a comprehensive multi-language code execution platform for mobile devices. The project demonstrates the practical application of modern mobile development technologies and architectural patterns to solve a real-world problem: providing programmers with a portable, convenient environment for writing and executing code on their smartphones.

Through the course of this project, a fully functional application has been delivered that enables users to write and execute code in Python, Java, and C++ through integration with the Wandbox compiler API, securely authenticate and manage their accounts through Firebase Authentication, perform complete CRUD operations on notes and tasks using Cloud Firestore, save and manage code snippets for future reference, track their code execution history with comprehensive metadata, receive local and push notifications for practice reminders and task deadlines, customize their editor preferences and application theme, and access educational information about supported programming languages.

The application encompasses 17 screen files, 5 service classes, 6 provider classes, 3 model classes, and 3 reusable widget files, representing a substantial codebase that demonstrates software engineering best practices including separation of concerns, modular architecture, and code reuse.

### 12.2 Learning Outcomes

The development of CodeXecute provided valuable hands-on experience across multiple domains of mobile application development. In terms of Flutter and Dart proficiency, the project deepened understanding of the widget lifecycle, state management patterns, asynchronous programming with Futures and Streams, animation controllers, and platform-specific configurations.

The Firebase integration aspects of the project provided practical experience with cloud-based authentication, real-time NoSQL database operations, and cloud messaging services. These are skills that are directly transferable to professional mobile development work.

The REST API integration work reinforced concepts of HTTP communication, JSON serialization and deserialization, error handling for network operations, and the importance of timeout mechanisms and graceful degradation when external services are unavailable.

The project also provided valuable experience in user interface design, emphasizing the importance of visual hierarchy, consistent theming, responsive layouts, accessibility considerations, and meaningful user feedback through animations, color coding, and notifications.

### 12.3 Real-World Importance

CodeXecute addresses a genuine need in the programming education and practice space. As mobile devices become increasingly powerful and ubiquitous, the ability to code on a smartphone is transitioning from a novelty to a practical necessity. Students who commute long hours, have limited access to computers, or simply want to make productive use of short breaks throughout their day can benefit from a tool like CodeXecute.

The application also serves as a practical demonstration of how modern cloud services and APIs can be combined to create powerful mobile applications without requiring dedicated server infrastructure. The integration of Firebase for authentication and database, along with the Wandbox API for code compilation, shows how a single developer or small team can leverage existing services to build feature-rich applications efficiently.

Furthermore, the project demonstrates the viability of Flutter as a framework for building complex, production-quality mobile applications. The single codebase approach, combined with near-native performance and a rich widget library, makes Flutter an excellent choice for projects that need to deliver a polished user experience while maintaining development efficiency.

---

\newpage

## 13. REFERENCES

---

1. **Flutter Official Documentation.** Available at: https://docs.flutter.dev/. Accessed during the project development for widget references, state management guides, and platform-specific configuration instructions.

2. **Dart Programming Language Documentation.** Available at: https://dart.dev/guides. Referenced for language features, asynchronous programming patterns, and package management.

3. **Firebase Documentation.** Available at: https://firebase.google.com/docs. Used extensively for Firebase Authentication setup, Cloud Firestore database operations, Firebase Cloud Messaging configuration, and platform-specific integration guides.

4. **Wandbox API Documentation.** Available at: https://github.com/melpon/wandbox. Referenced for compiler API endpoints, supported compilers and their identifiers, request and response formats, and available programming language versions.

5. **JSONPlaceholder - Free Fake REST API.** Available at: https://jsonplaceholder.typicode.com/. Used as a sample REST API for demonstrating API data fetching and display functionality.

6. **Provider Package Documentation.** Available at: https://pub.dev/packages/provider. Referenced for state management implementation patterns, ChangeNotifier usage, Consumer and Selector widget guidelines.

7. **flutter_local_notifications Package.** Available at: https://pub.dev/packages/flutter_local_notifications. Used for implementing local notification features including instant notifications, scheduled notifications, and notification channel configuration.

8. **firebase_messaging Package.** Available at: https://pub.dev/packages/firebase_messaging. Referenced for Firebase Cloud Messaging integration, including foreground and background message handling.

9. **SharedPreferences Package.** Available at: https://pub.dev/packages/shared_preferences. Used for local key-value storage implementation for session persistence and user preferences.

10. **Hive Database Package.** Available at: https://pub.dev/packages/hive. Referenced for local database storage implementation for code snippets and execution history.

11. **http Package.** Available at: https://pub.dev/packages/http. Used for making HTTP requests to the Wandbox API and JSONPlaceholder API.

12. **Material Design 3 Guidelines.** Available at: https://m3.material.io/. Referenced for user interface design principles, color system, typography, and component specifications.

13. **Android Studio IDE.** Available at: https://developer.android.com/studio. Used as the primary development environment for Flutter application development and Android device emulation.

14. **Git Version Control.** Available at: https://git-scm.com/. Used for source code version control and change tracking throughout the project development lifecycle.

---

**End of Report**

---
