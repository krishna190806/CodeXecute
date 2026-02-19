# LABORATORY REPORT - 7

**Student Name:** Krishna  
**Roll No:** [Your Roll No]  
**Subject:** Mobile Application Development (MAD)  
**Lab Title:** Implementation of Essential UI Components & User Controls  

---

### 1. AIM
To design and implement a comprehensive mobile application UI using Flutter that demonstrates the use of essential UI components (TextField, Button, ListView, Card, Dialog, etc.) and user controls, ensuring a professional and responsive user experience.

### 2. TOOLS & TECHNOLOGIES
- **Framework:** Flutter
- **Language:** Dart
- **IDE:** VS Code / Android Studio
- **Backend (Optional used):** Firebase Firestore (for data persistence)

### 3. INTRODUCTION
User Interface (UI) design is critical in mobile application development. A good UI is intuitive, responsive, and visually appealing. In this lab, we implemented a "Productivity App" that includes authentication (Login/Register), a Dashboard with navigation to different modules (Notes, Tasks, Profile), and CRUD interfaces. The application utilizes Material Design widgets to ensure consistency across Android and iOS platforms. Key components used include text inputs with validation, list views for displaying data, floating action buttons for primary actions, and dialogs for user confirmation.

### 4. SCREEN OVERVIEW
The application consists of the following key screens:
1.  **Login & Registration:** Secure entry points with validation and password visibility toggles.
2.  **Dashboard:** A central hub using a GridView to navigate to Notes, Tasks, Profile, and Settings.
3.  **Notes/Tasks List:** Displays items in a ListView using Card widgets for better visual separation.
4.  **Add/Edit Screen:** A form-based screen to create or update content.
5.  **Profile:** Displays user details and provides a logout option.

### 5. IMPLEMENTATION DETAILS

#### A. Dashboard Screen (`dashboard_screen.dart`)
The dashboard serves as the home screen, featuring a personalized greeting and a grid navigation menu.

```dart
// Snippet from DashboardScreen
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('CodeXecute')),
    body: Column(
      children: [
        Text('Welcome, User!', style: Theme.of(context).textTheme.headlineSmall),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              _buildFeatureCard(title: 'Notes', icon: Icons.note_outlined, ...),
              _buildFeatureCard(title: 'Tasks', icon: Icons.check_circle_outline, ...),
              // ...
            ],
          ),
        ),
      ],
    ),
  );
}
```

#### B. Input Handling (`add_edit_screen.dart`)
We created a reusable `AddEditScreen` that handles both creating and editing items. It uses `TextFormField` validation.

```dart
// Snippet from AddEditScreen
TextFormField(
  controller: _titleController,
  decoration: InputDecoration(
    labelText: 'Title',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.title),
  ),
  validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
)
```

#### C. List Display (`tasks_screen.dart`)
The `ListView.builder` is used to efficiently display a scrolling list of tasks managed by Firestore.

```dart
// Snippet from TasksScreen
ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (context, index) {
    var task = snapshot.data!.docs[index];
    return Card(
      child: ListTile(
        title: Text(task['title']),
        subtitle: Text(task['description']),
        leading: Checkbox(value: task['isCompleted'], onChanged: ...),
      ),
    );
  },
)
```

#### D. Profile & Dialogs
The Profile screen displays user info using `CircleAvatar` and `ListTile`. Dialogs are used for delete confirmation (`AlertDialog`) and notifications (`SnackBar`).

### 6. RESULT
The application successfully demonstrates a functional and aesthetic UI.
- Users can log in and navigate to different sections.
- The dashboard provides quick access to core features.
- Lists are rendered smoothly with real-time updates from Firestore.
- Forms validate input correctly before submission.
- The Overall UI follows Material Design guidelines.

### 7. CONCLUSION
In this lab, we successfully explored and implemented various Flutter UI components. We learned how to structure a multi-screen application, handle user input with forms, display dynamic lists, and manage navigation. The use of widgets like `GridView`, `ListView`, `Card`, and `TextFormField` allowed us to create a polished and user-friendly interface suitable for real-world applications.
