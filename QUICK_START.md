## 🚀 Quick Start Guide

### Getting Started in 3 Steps

#### 1️⃣ Launch the App
- Open CodeXecute app on your mobile device
- You'll see the beautiful compiler screen

#### 2️⃣ Choose Your Language
- Tap the **language dropdown** in the top-right
- Select from: **🐍 Python**, **☕ Java**, or **⚙️ C++**

#### 3️⃣ Write & Execute Code
- Type your code in the editor
- (Optional) Add stdin input below
- Tap the **▶️ Run Code** button
- See your results instantly in the output section!

---

## 📚 Using Code Snippets

### Quick Code Templates
1. Tap the **📚 Template** button
2. Choose from dozens of pre-built examples
3. Your code is instantly inserted!
4. Modify and run immediately

### Available Snippet Categories
- Hello World programs
- Variable declarations
- Loops and conditions
- Arrays and collections
- Functions and methods
- Classes and OOP
- Exception handling
- File operations
- String manipulation
- Math operations

---

## 🎓 Learning Resources

### Access Language Guide
1. Tap the **🎓 Learn** icon (school icon) at the top
2. Select your language: Python, Java, or C++
3. Browse:
   - **Language Overview** - What the language is good for
   - **Key Features** - Main capabilities
   - **💡 Quick Tips** - Coding best practices
   - **🚨 Common Errors** - Mistakes and fixes
   - **⭐ Best Practices** - Professional standards

---

## ✍️ Writing Effective Code

### Tips for Success

**Python:**
```python
# ✅ Use consistent indentation (4 spaces)
# ✅ Use meaningful variable names
# ✅ Add functions for reusability
# ✅ Use list comprehensions for elegance

name = input("What's your name? ")
print(f"Hello, {name}!")
```

**Java:**
```java
// ✅ Public class name matches file
// ✅ Always include main() method
// ✅ Use camelCase for variables
// ✅ Initialize all variables

String name = "CodeXecute";
System.out.println("Hi " + name);
```

**C++:**
```cpp
// ✅ Include necessary headers
// ✅ Use std namespace or std::
// ✅ Include return statements
// ✅ Use meaningful function names

#include <iostream>
int main() {
    std::cout << "Hello!";
    return 0;
}
```

---

## 🎯 Common Tasks

### Read User Input
**Python:**
```python
name = input("Enter name: ")
age = int(input("Enter age: "))
```

**Java:**
```java
Scanner sc = new Scanner(System.in);
String name = sc.nextLine();
int age = sc.nextInt();
```

**C++:**
```cpp
string name;
int age;
cin >> name >> age;
```

### Loop Through Numbers
**Python:**
```python
for i in range(1, 6):
    print(f"Number: {i}")
```

**Java:**
```java
for (int i = 1; i <= 5; i++) {
    System.out.println("Number: " + i);
}
```

**C++:**
```cpp
for (int i = 1; i <= 5; i++) {
    cout << "Number: " << i << endl;
}
```

### Create a Function
**Python:**
```python
def add(a, b):
    return a + b

result = add(5, 3)
print(result)  # Output: 8
```

**Java:**
```java
static int add(int a, int b) {
    return a + b;
}

int result = add(5, 3);
System.out.println(result);  // 8
```

**C++:**
```cpp
int add(int a, int b) {
    return a + b;
}

int result = add(5, 3);
cout << result;  // 8
```

---

## ⚠️ Debugging Tips

### When Code Doesn't Work

1. **Read the error message carefully**
   - Most errors tell you exactly what's wrong
   - Note the error type (SyntaxError, TypeError, CompileError, etc.)

2. **Check Common Mistakes:**
   - ✅ All brackets/braces matched: `{}`  `[]`  `()`
   - ✅ Colons where required (Python, Java, C++)
   - ✅ Indentation is consistent (Python)
   - ✅ Variable names are defined before use
   - ✅ Data types are compatible

3. **Test Incrementally**
   - Write small piece
   - Execute and verify
   - Add more code
   - Repeat

4. **Use Print Statements**
   - Insert print/cout/System.out to trace code
   - See what values variables have
   - Identifies where code goes wrong

### Example Error & Fix

**❌ Error:**
```
IndentationError: expected an indented block
```
**✅ Fix:**
```python
# Wrong:
if x > 5:
print("x is big")  # Not indented!

# Correct:
if x > 5:
    print("x is big")  # Properly indented
```

---

## 🌟 Pro Tips

### 1. Use Templates First
Don't write from scratch! Use templates to speed up coding.

### 2. Test with Sample Input
Always test with the stdin input field to ensure your program handles input correctly.

### 3. Execution Time Matters
Watch the execution time! If it's slow:
- Simplify logic
- Avoid infinite loops
- Optimize algorithm

### 4. Learn by Doing
- Run snippets and modify them
- Experiment with different approaches
- Study error messages to learn faster

### 5. Check Version Info
Each language shows its compiler version. Different versions may behave differently.

---

## 🎨 UI Features Explained

| Element | Purpose |
|---------|---------|
| **Language Dropdown** | Select Python/Java/C++ |
| **Learn Icon** | Access language learning guide |
| **Code Editor** | Write your code here |
| **Input Field** | Provide stdin data (optional) |
| **Template Button** | Insert code snippets |
| **Clear Button** | Reset editor and output |
| **Output Area** | Shows program results |
| **Execution Time** | How long compilation took |
| **Run Button** | Execute your code |

---

## 📊 Code Statistics

The app shows you code stats:
- **📝 Lines** - Number of lines of code
- **💾 Size** - File size in bytes/KB/MB
- **🔧 Functions** - Number of functions/methods

Use these to:
- Track code complexity
- Understand code scale
- Identify optimization opportunities

---

## 🔧 Setting Up Input/Output

### Example: Number Sum Program

**Code:**
```python
n = int(input("How many numbers? "))
total = 0
for i in range(n):
    num = int(input(f"Number {i+1}: "))
    total += num
print(f"Sum: {total}")
```

**Input (in Input field):**
```
3
5
10
15
```

**Output:**
```
Sum: 30
```

---

## 🎓 Learning Paths

### Beginner
1. Run "Hello World" snippet
2. Modify the output message
3. Try "Variables" snippet
4. Read language tips in Learn section
5. Create simple input/output program

### Intermediate
1. Use "Loop Example" snippet
2. Modify loop conditions
3. Try "Function" snippet
4. Create your own functions
5. Reference Learn section for syntax

### Advanced
1. Explore "Class Example" snippet
2. Implement OOP concepts
3. Use complex data structures
4. Optimize algorithm performance
5. Reference Best Practices section

---

## 📱 Mobile Tips

- **Landscape Mode:** Rotate phone for bigger editor
- **Quick Snippets:** Templates save typing time
- **Input Field:** Use for testing programs requiring user input
- **Output Scroll:** Large output? Scroll to see everything
- **Quick Switch:** Easily change languages without losing code*

*Tip: Your editor code is preserved when switching to/from the Learn screen!

---

## ❓ FAQ

**Q: Can I save my code?**
A: The app saves text during your session. For permanent storage, take screenshots or copy to notes.

**Q: Does it work offline?**
A: Compilation requires internet (uses Wandbox API). Edit offline but execute online.

**Q: What if code times out?**
A: Compilation has a 30-second limit. Simplify your code or reduce input size.

**Q: Can I run multiple files?**
A: Currently supports single-file programs. Multi-file in future versions.

**Q: Are there more languages coming?**
A: Python, Java, and C++ are currently supported. More languages planned!

---

## 🚀 Ready to Code?

You're all set! Start with a template, explore the snippets, learn from the guide, and write amazing code!

**Happy Coding! 💻✨**

---

*For more details, see the full FEATURES.md documentation*
