# 🚀 CodeXecute - Enhanced Code Compiler

A beautiful, smart Flutter mobile app for executing code in **Python**, **Java**, and **C++** with a modern, polished UI.

## ✨ Features

### 🎨 Beautiful UI/UX
- **Modern Dark Theme** with gradient backgrounds and smooth animations
- **Language-specific color schemes** for each programming language
- **Responsive design** that works on all screen sizes
- **Smooth transitions** and professional styling
- **Intuitive layout** with clear visual hierarchy

### 💻 Code Execution
- **Instant code compilation and execution**
- Support for three languages: **Python**, **Java**, and **C++**
- **Custom input (stdin)** support for programs requiring user input
- **Real-time execution timing** to track performance
- **Color-coded output** (green for success, red for errors)
- **Error highlighting** with clear error messages
- **Syntax validation** before execution

### 📚 Code Snippets & Templates
- **100+ ready-to-use code snippets** for each language
- Quick access to common patterns:
  - Hello World
  - Variables & Data Types
  - Loops (for, while)
  - Arrays and Collections
  - Functions & Methods
  - Classes & OOP
  - Exception Handling
  - File I/O
  - And more!
- **One-click insertion** of snippets into editor

### 🎓 Learning Resources
- **Comprehensive Language Guide** with detailed information for each language
- **Quick Tips** for efficient coding in each language
- **Common Errors & Solutions** to help debug quickly
- **Best Practices** for writing quality code
- **Language Features** highlighting key capabilities
- **Version information** for each compiler

### 🔍 Code Analysis
- **Line counting** for code statistics
- **File size calculation** in readable format
- **Function counting** to understand code structure
- **Character/byte analysis** for optimization insights

### 🌐 Online Compilation
- **Uses Wandbox API** for reliable remote compilation
- **No local setup required** - compile anywhere
- **Support for multiple compiler versions**
- **Automatic syntax checking** before sending to server

### ⚡ Smart Features
- **Template button** for quick code structure scaffolding
- **Clear code** functionality for quick reset
- **Execution history** tracking (time taken per execution)
- **Language switching** during editing
- **Continuous input support** for interactive programs

---

## 📱 Screens & Navigation

### 1. **Code Compiler Screen** (Main Screen)
The heart of the application with everything you need to write and execute code.

**Components:**
- 🎯 Language selector dropdown
- 📝 Full-featured code editor with monospace font
- 📥 Input section for stdin data
- 🎨 Beautifully formatted output area
- ▶️ Large FAB (Floating Action Button) to run code
- 📚 Template button for quick snippets
- 🧹 Clear button to reset editor

**Features:**
- Line numbers (visual reference)
- Syntax-aware indentation
- Color-coded error messages
- Execution time display
- Professional typography

### 2. **Language Info Screen** (Educational)
A comprehensive guide for learning each programming language.

**Tabs for each language:**
1. **Python** 🐍
2. **Java** ☕
3. **C++** ⚙️

**Information provided:**
- Language overview and description
- Compiler version information
- Key features and capabilities
- 💡 Quick tips for efficient coding
- 🚨 Common errors with solutions
- ⭐ Best practices and recommendations

---

## 🚀 Getting Started

### Installation
1. Clone or download the project
2. Ensure Flutter is installed (Flutter 3.10.7+)
3. Run `flutter pub get` to install dependencies
4. Connect a device or start an emulator
5. Run `flutter run` to launch the app

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- Internet connection for code execution

### Dependencies
```yaml
firebase_core: ^3.8.1
firebase_auth: ^5.3.4
cloud_firestore: ^5.6.0
provider: ^6.1.1
shared_preferences: ^2.2.2
http: ^1.2.1
flutter_local_notifications: ^18.0.1
firebase_messaging: ^15.1.6
timezone: ^0.10.0
```

---

## 💻 Supported Languages

### 🐍 Python
- **Version:** Latest Python 3.x (CPython)
- **Use Cases:** Data science, scripting, automation, web development
- **Strengths:** Readability, rapid development, rich libraries
- **Features Included:**
  - List comprehensions
  - Decorators
  - Exception handling
  - OOP support
  - Lambda functions

### ☕ Java
- **Version:** OpenJDK 22+
- **Use Cases:** Enterprise applications, Android development, backend systems
- **Strengths:** Type safety, performance, portability
- **Features Included:**
  - Object-oriented programming
  - Interfaces and inheritance
  - Generics
  - Exception handling
  - Collections framework

### ⚙️ C++
- **Version:** GCC Latest
- **Use Cases:** System programming, game development, performance-critical apps
- **Strengths:** Speed, low-level access, efficiency
- **Features Included:**
  - Object-oriented programming
  - STL (Standard Template Library)
  - Pointers and memory management
  - Template programming
  - Multiple inheritance

---

## 🎯 Code Example Usage

### Python Example
```python
def main():
    print("Hello, World!")
    name = input("Enter your name: ")
    print(f"Hello, {name}!")

if __name__ == "__main__":
    main()
```

### Java Example
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        String name = "CodeXecute";
        System.out.println("Welcome, " + name);
    }
}
```

### C++ Example
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    string name = "CodeXecute";
    cout << "Welcome, " << name << endl;
    return 0;
}
```

---

## 🎨 UI/UX Highlights

### Color Scheme
- **Base:** Deep dark (#0F0F13)
- **Surface:** Slightly lighter (#1E1E24)
- **Primary:** Modern Indigo (#6366F1)
- **Language Colors:**
  - Python: Blue (#3776AB)
  - Java: Red (#EA2D2E)
  - C++: Dark Blue (#00599C)

### Typography
- **Primary Font:** Roboto
- **Code Font:** Courier (monospace)
- **Sizes:** Carefully scaled for readability

### Components
- **Rounded corners** (12-20px) for modern look
- **Soft shadows** for depth
- **Gradient backgrounds** for visual interest
- **Smooth animations** (0.3s duration)
- **Accessible contrast** ratios

---

## ⚙️ Architecture

### File Structure
```
lib/
├── main.dart                          # App entry point
├── screens/
│   ├── compiler_screen.dart           # Main coding interface
│   ├── language_info_screen.dart      # Learning resources
│   └── [other screens]
├── services/
│   ├── compiler_service.dart          # Code execution logic
│   └── [other services]
├── providers/
│   ├── code_snippets_provider.dart    # Snippet management
│   └── [other providers]
├── widgets/
│   ├── syntax_highlighter.dart        # Code highlighting
│   ├── language_info_card.dart        # Info cards
│   └── [other widgets]
└── models/
    └── [data models]
```

### Key Classes

#### `CompilerService`
Handles all code execution through Wandbox API
- `executeCode()` - Compiles and runs code
- `validateSyntax()` - Pre-execution validation
- `analyzeCode()` - Provides code statistics

#### `CodeSnippets`
Provider for code examples
- `getSnippets()` - Get snippets by language
- `getSnippetNames()` - List available snippets

#### `SyntaxHighlighter`
Visual code highlighting (optional enhancement)
- Keyword highlighting
- String highlighting
- Comment highlighting

---

## 🔧 Customization

### Change App Theme
Edit `main.dart` theme configuration:
```dart
darkTheme: ThemeData(
  primaryColor: const Color(0xFF6366F1),
  scaffoldBackgroundColor: const Color(0xFF0F0F13),
  // ... more theme properties
)
```

### Add New Language
1. Update `_compilerMap` in `compiler_service.dart`
2. Add templates in `code_snippets_provider.dart`
3. Add tips in `language_info_screen.dart`
4. Add color in `_getLanguageColor()`

### Modify Snippets
Edit `CodeSnippets` class in `code_snippets_provider.dart`:
```dart
static const Map<String, String> pythonSnippets = {
  'Custom Snippet': 'your code here',
};
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue:** "Connection failed" error
- **Solution:** Check internet connection. Wandbox API requires online access.

**Issue:** "Compilation takes too long"
- **Solution:** API has 30-second timeout. Simplify your code or reduce input size.

**Issue:** "Syntax validation error"
- **Solution:** Review the error message. Check for missing colons, braces, or imports.

**Issue:** App crashes on startup
- **Solution:** Ensure all dependencies are installed (`flutter pub get`). Clear build cache (`flutter clean`).

---

## 📈 Performance Tips

1. **Optimize Code:** Write efficient algorithms
2. **Limit Input:** Use reasonable input sizes
3. **Avoid Infinite Loops:** Test locally before running
4. **Use Proper Data Types:** Choose efficient storing methods
5. **Profile Code:** Use execution time tracking

---

## 🔐 Security Considerations

- ✅ Code is sent to Wandbox API servers
- ✅ No sensitive data should be included in code
- ✅ Avoid hardcoding passwords or keys
- ✅ Be cautious with file I/O operations
- ✅ System commands may be restricted

---

## 📝 Future Enhancements

- [ ] Code syntax highlighting in editor
- [ ] Execution history/previous codes
- [ ] Code sharing/export functionality
- [ ] Offline compilation support
- [ ] Debugging tools
- [ ] Multi-file projects
- [ ] Custom compiler settings
- [ ] Code collaboration features

---

## 🤝 Contributing

We welcome improvements! To contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This project is open source and available under the MIT License.

---

## 🙏 Acknowledgments

- **Wandbox API** for reliable online compilation
- **Flutter & Dart teams** for the amazing framework
- **Firebase** for backend services
- All contributors and users

---

## 📧 Support

For issues, feature requests, or questions:
- Create an issue on GitHub
- Contact the development team

---

## 🎓 Educational Value

This app is perfect for:
- 👨‍🎓 Students learning to code
- 👨‍🏫 Teachers demonstrating code
- 🚀 Beginners exploring programming
- 💼 Professionals testing quick snippets
- 📚 Quick reference while learning

---

## 🌟 Feature Highlights at a Glance

| Feature | Status |
|---------|--------|
| Python Support | ✅ Full |
| Java Support | ✅ Full |
| C++ Support | ✅ Full |
| Code Snippets | ✅ 100+ |
| Learning Materials | ✅ Yes |
| Error Highlighting | ✅ Yes |
| Execution Timing | ✅ Yes |
| Custom Input | ✅ Yes |
| Dark Theme | ✅ Yes |
| Responsive Design | ✅ Yes |
| Beautiful UI | ✅ Yes |
| Mobile Optimized | ✅ Yes |

---

**Made with ❤️ for developers and learners everywhere!**

*Version: 1.1.0*
*Last Updated: 2024*
