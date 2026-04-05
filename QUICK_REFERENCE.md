# 🔖 CodeXecute Quick Reference Card

## 🎮 Control Guide

### Main Screen Controls

| Button | Action | Shortcut |
|--------|--------|----------|
| **🎓 Learn** | Open language guide | Top-right icon |
| **📚 Template** | Insert code snippet | Bottom button |
| **🧹 Clear** | Reset editor & input | Bottom button |
| **▶️ Run Code** | Execute your code | Large floating button |
| **⬇️ Dropdown** | Change language | Top-right |
| **📥 Input** | Set stdin data | Text field |
| **📤 Output** | View results | Auto-scrolling |

---

## 🐍 Python Quick Tips

### Syntax
```python
# Variables
name = "Python"      # String
age = 25             # Integer

# Loops
for i in range(5):   # 0-4
    print(i)

# Function
def add(a, b):
    return a + b

# Class
class Person:
    def __init__(self, name):
        self.name = name
```

### Common Patterns
- **Input:** `name = input("Enter: ")`
- **Output:** `print(f"Hello {name}")`
- **List:** `arr = [1, 2, 3]`
- **Dict:** `person = {"name": "Bob", "age": 30}`

### Common Errors
```
❌ IndentationError
   → Fix: Use consistent indentation

❌ NameError: name not defined
   → Fix: Declare variable before use

❌ TypeError: unsupported operand
   → Fix: Check data types compatibility
```

---

## ☕ Java Quick Tips

### Syntax
```java
// Variables
String name = "Java";    // String
int age = 25;            // Integer

// For Loop
for (int i = 0; i < 5; i++) {
    System.out.println(i);
}

// Function
static int add(int a, int b) {
    return a + b;
}

// Class
class Person {
    String name;
    Person(String n) { name = n; }
    void greet() {
        System.out.println("Hi " + name);
    }
}
```

### Common Patterns
- **Input:** `Scanner sc = new Scanner(System.in);`
- **Output:** `System.out.println("text");`
- **Array:** `int[] arr = {1, 2, 3};`
- **ArrayList:** `ArrayList<Integer> list = new ArrayList<>();`

### Common Errors
```
❌ class is public, should be declared in a file
   → Fix: Rename file to match class name

❌ NullPointerException
   → Fix: Initialize object before use

❌ Cannot find symbol
   → Fix: Check spelling and imports
```

---

## ⚙️ C++ Quick Tips

### Syntax
```cpp
#include <iostream>
using namespace std;

// Variables
string name = "C++";     // String
int age = 25;            // Integer

// For Loop
for (int i = 0; i < 5; i++) {
    cout << i << endl;
}

// Function
int add(int a, int b) {
    return a + b;
}

// Class
class Person {
public:
    string name;
    Person(string n) { name = n; }
    void greet() {
        cout << "Hi " << name << endl;
    }
};
```

### Common Patterns
- **Input:** `cin >> variable;`
- **Output:** `cout << "text" << endl;`
- **Array:** `int arr[] = {1, 2, 3};`
- **Vector:** `vector<int> vec = {1, 2, 3};`

### Common Errors
```
❌ Undefined reference to main
   → Fix: Add int main() function

❌ Segmentation fault
   → Fix: Check pointer validity

❌ No match for operator
   → Fix: Check type compatibility
```

---

## 🎨 UI Elements Reference

### Colors & Meanings
```
🔵 Blue (Python)   - #3776AB
🔴 Red (Java)      - #EA2D2E  
⚫ C++ (Dark Blue)  - #00599C
🟢 Green (Success) - #00FF00
🔴 Red (Error)     - #FF6B6B
⚪ Gray (Info)     - #CCCCCC
```

### Section Headers
```
💻 Code Editor       - Where to write code
📥 Input            - Where to add stdin
📤 Output           - Where results show
❌ Error            - Shows errors (red)
✅ Success          - Shows output (green)
```

---

## 📝 Code Templates

### Python Template (Hello World)
```python
# Python Template
def main():
    print("Hello, World!")
    name = input("Enter your name: ")
    print(f"Hello, {name}!")

if __name__ == "__main__":
    main()
```
**To Use:** Tap Template button → Select "Hello World"

### Java Template (Hello World)
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        String name = "CodeXecute";
        System.out.println("Welcome, " + name);
    }
}
```
**To Use:** Tap Template button → Select "Hello World"

### C++ Template (Hello World)
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
**To Use:** Tap Template button → Select "Hello World"

---

## 🚀 Common Tasks

### Task: Read Integer Input
**Python:**
```python
num = int(input("Enter a number: "))
print(f"You entered: {num}")
```

**Java:**
```java
Scanner sc = new Scanner(System.in);
int num = sc.nextInt();
System.out.println("You entered: " + num);
```

**C++:**
```cpp
int num;
cin >> num;
cout << "You entered: " << num << endl;
```

### Task: Loop & Count
**Python:**
```python
for i in range(1, 6):
    print(f"{i} * 2 = {i * 2}")
```

**Java:**
```java
for (int i = 1; i <= 5; i++) {
    System.out.println(i + " * 2 = " + (i * 2));
}
```

**C++:**
```cpp
for (int i = 1; i <= 5; i++) {
    cout << i << " * 2 = " << (i * 2) << endl;
}
```

### Task: Sum Array
**Python:**
```python
arr = [1, 2, 3, 4, 5]
print(f"Sum: {sum(arr)}")
```

**Java:**
```java
int[] arr = {1, 2, 3, 4, 5};
int sum = 0;
for (int num : arr) sum += num;
System.out.println("Sum: " + sum);
```

**C++:**
```cpp
vector<int> arr = {1, 2, 3, 4, 5};
int sum = 0;
for (int num : arr) sum += num;
cout << "Sum: " << sum << endl;
```

---

## ⏱️ Timing Reference

| Code Type | Expected Time | Status |
|-----------|---|---|
| Hello World | 10-20ms | ⚡ Fast |
| Simple loop | 20-50ms | ⚡ Fast |
| Array operations | 30-100ms | ⚡ Fast |
| Complex algorithm | 100-500ms | ⚙️ Normal |
| Slow algorithm | 500ms+ | 🐌 Slow |
| Timeout | 30000ms+ | ❌ Failed |

---

## 🎓 Learning Checklist

### Beginner Level
- [ ] Run first Hello World
- [ ] Modify print statement
- [ ] Use template snippets
- [ ] Understand variables
- [ ] Try loops
- [ ] Read basic tips

### Intermediate Level
- [ ] Create functions
- [ ] Build classes
- [ ] Handle errors
- [ ] Study best practices
- [ ] Compare approaches
- [ ] Optimize code

### Advanced Level
- [ ] Complex algorithms
- [ ] OOP principles
- [ ] Performance optimization
- [ ] Edge cases
- [ ] Professional patterns
- [ ] Code review

---

## 🔍 Debugging Guide

### Step 1: Read Error Message
```
Look at the error type and line number
​Examples:
- SyntaxError (Python)
- CompileError (Java)
- Runtime Error (C++)
```

### Step 2: Check Common Mistakes
- [ ] Indentation correct?
- [ ] Brackets/braces matched?
- [ ] Semicolons included?
- [ ] Variables declared?
- [ ] Types compatible?

### Step 3: Test Small Piece
```
Don't test entire program at once
Test piece by piece using print statements
Isolate problem areas
Verify each part works
```

### Step 4: Compare with Template
- Find similar code in templates
- Compare line by line
- Check for differences
- Apply fixes

---

## 💾 Saving Work

**Current Session:** Auto-saved while editing

**Moving Code:**
1. Copy from output
2. Paste into notes/file
3. Export from device

**Long-term Storage:**
- Use device notes app
- Store in cloud
- Use code repository
- Screenshot results

---

## 🎯 Performance Tips

### Code Writing
- ✅ Use templates to start
- ✅ Write incrementally
- ✅ Test frequently
- ✅ Keep code simple
- ✅ Avoid infinite loops

### Execution
- ✅ Start with small input
- ✅ Increase gradually
- ✅ Monitor timing
- ✅ Optimize if slow
- ✅ Simplify complex logic

### Learning
- ✅ Focus on one concept
- ✅ Practice regularly
- ✅ Review mistakes
- ✅ Compare languages
- ✅ Read best practices

---

## 📚 Resource Links

| Resource | What | Where |
|----------|------|-------|
| Language Info | Tips & Guide | Tap Learn button |
| Code Snippets | Examples | Tap Template button |
| Best Practices | Pro tips | Open Learn → Best Practices |
| Common Errors | Fixes | Open Learn → Common Errors |

---

## 🎮 Keyboard Tips

### Text Editing (Mobile Keyboard)
- **{ }** - Parentheses (shift if needed)
- **Tab** - Indentation (autocomplete)
- **↩️** - New line
- **⌫** - Backspace/delete

### Input Field
- Tap to focus
- Type data
- Press done
- Use for stdin

---

## 🌐 Language Comparison Matrix

| Feature | Python | Java | C++ |
|---------|--------|------|-----|
| Learning Curve | Easy | Medium | Hard |
| Execution Speed | Slower | Fast | Fastest |
| Object-Oriented | Yes | Full | Yes |
| Static Typing | Optional | Required | Required |
| Best For | Data/Scripts | Enterprise | Performance |

---

## ✅ Pre-Execution Checklist

Before running code, verify:
- [ ] Code editor not empty
- [ ] Appropriate language selected
- [ ] Syntax looks correct
- [ ] All brackets matched
- [ ] Required keywords present
- [ ] Input provided (if needed)

---

## 🎁 Bonus Features

### Easter Eggs (Experimental)
- Language emojis in headers
- Color transitions on language switch
- Smooth loading animations
- Premium dark theme

### Hidden Capabilities
- Horizontal scroll in editor
- Long-press for copy
- Pinch to zoom (if enabled)
- Gesture navigation

---

## 📞 Quick Help

### "My code won't run"
1. Check error message
2. Search in "Common Errors"
3. Compare with template
4. Use template as base

### "I don't understand"
1. Read language tips
2. Study code examples
3. Try templates
4. Review best practices

### "How do I...?"
1. Check QUICK_START.md
2. Look at templates
3. Try Learn section
4. Experiment!

---

## 🎨 Customization Tips

### Change Language Anytime
1. Tap dropdown (top-right)
2. Select new language
3. Code preserved
4. Ready to execute

### Reuse Previous Code
1. Template button
2. Select similar snippet
3. Modify as needed
4. Test and run

### Learn While Coding
1. Hit Learn button
2. Browse tips for language
3. Return to editor
4. Apply what you learned

---

## 🚀 Power User Tips

### Pro Level 1
- Use templates as base
- Modify for practice
- Study each change
- Compare output

### Pro Level 2
- Create complex programs
- Optimize for speed
- Handle edge cases
- Follow best practices

### Pro Level 3
- Master multi-language
- Understand tradeoffs
- Build real projects
- Share knowledge

---

## 📊 Code Metrics Explained

### Lines
Total code lines (helps gauge complexity)

### Size
File size in B/KB/MB (larger = more complex?)

### Functions
Number of functions/methods (code organization)

**Use for:** Understanding code structure

---

## 🎉 You're All Set!

Now you have:
- ✅ Quick reference for all languages
- ✅ Common tasks & solutions
- ✅ Tips and tricks
- ✅ Debugging guide
- ✅ Complete command guide

**Keep this card handy for fast reference!** 📌

---

**Happy Coding!** 🚀✨

*Last Updated: March 2024*
*Version: 2.0.0 Enhanced*
