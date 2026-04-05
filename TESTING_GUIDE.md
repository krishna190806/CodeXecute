# CodeXecute Output Display - Testing Guide

## Quick Start - Verify Fixes

### Step 1: Run the App
```bash
flutter run
```

Or for web:
```bash
flutter run -d chrome
```

### Step 2: Navigate to Compiler Screen
- Tap the **Compiler** button from dashboard
- Or navigate from sidebar menu → Code Editor

### Step 3: Test Sample Codes

---

## Test Cases

### ✅ Test 1: Python - Simple Output
**Language:** Python  
**Code:**
```python
print("Hello from CodeXecute!")
print("Python version: 3.x")
print("Testing output display...")
for i in range(1, 4):
    print(f"Line {i}")
```
**Expected Result:**
- Output displays in green color
- Shows all 4 print statements
- Execution time displays at top (e.g., "Executed in 1234ms")

---

### ✅ Test 2: Python - With Input (stdin)
**Language:** Python  
**Code:**
```python
name = input("Enter your name: ")
age = input("Enter your age: ")
print(f"Hello {name}, you are {age} years old!")
```
**Input (stdin field):**
```
John
25
```
**Expected Result:**
- Shows both input prompts and outputs
- Output displays in green
- Shows complete conversation

---

### ✅ Test 3: Java - Simple HelloWorld
**Language:** Java  
**Code:**
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Java!");
        System.out.println("Java version: 22+");
        for (int i = 1; i <= 3; i++) {
            System.out.println("Java Line " + i);
        }
    }
}
```
**Expected Result:**
- Output displays in green
- Shows all 4 print statements
- Execution time displays
- No errors

---

### ✅ Test 4: Java - With Input
**Language:** Java  
**Code:**
```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter two numbers:");
        int a = sc.nextInt();
        int b = sc.nextInt();
        System.out.println("Sum: " + (a + b));
    }
}
```
**Input (stdin field):**
```
10
20
```
**Expected Result:**
- Shows input prompt
- Calculates and displays "Sum: 30"
- Output in green

---

### ✅ Test 5: C++ - Simple Output
**Language:** C++  
**Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello from C++!" << endl;
    cout << "C++ version: GCC Latest" << endl;
    for (int i = 1; i <= 3; i++) {
        cout << "C++ Line " << i << endl;
    }
    return 0;
}
```
**Expected Result:**
- Output displays in green
- Shows all 4 cout statements
- Execution time displays

---

### ✅ Test 6: C++ - With Input
**Language:** C++  
**Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Enter your name: ";
    string name;
    cin >> name;
    cout << "Hello " << name << "!" << endl;
    return 0;
}
```
**Input (stdin field):**
```
CodeExecUser
```
**Expected Result:**
- Shows input prompt
- Displays greeting with input name
- Output in green

---

### ❌ Test 7: Python - Syntax Error
**Language:** Python  
**Code:**
```python
print("Missing closing quote
y = 10
```
**Expected Result:**
- Output displays in RED color  
- Shows error message from compiler
- Indicates syntax error location if possible

---

### ❌ Test 8: Java - Compilation Error
**Language:** Java  
**Code:**
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Missing semicolon")
    }
}
```
**Expected Result:**
- Output displays in RED color
- Shows compilation error
- Points to missing semicolon

---

### ❌ Test 9: C++ - Compilation Error
**Language:** C++  
**Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Undeclared variable: " << undefined_var << endl;
    return 0;
}
```
**Expected Result:**
- Output displays in RED color
- Shows compiler error about undefined variable
- Error in red text

---

### ⏱️ Test 10: Timeout Handling
**Language:** Python  
**Code:**
```python
import time
while True:
    time.sleep(1)
```
**Expected Result:**
- After 30 seconds, displays timeout error
- Error in red color
- Suggests simplifying code
- Shows message: "⏱️ Timeout: Compilation took too long"

---

## Feature Verification Checklist

### Output Display
- [ ] Green text for successful code execution
- [ ] Red text for errors/failures
- [ ] Execution time shown at top of output box
- [ ] Long outputs can be scrolled
- [ ] Output text can be selected and copied
- [ ] Empty output shows placeholder: "✨ Run code to see output"
- [ ] Proper line spacing and formatting

### Error Handling
- [ ] Syntax errors caught and displayed
- [ ] Compile errors show with line numbers
- [ ] Runtime errors displayed separately
- [ ] Network errors show helpful message
- [ ] Timeout errors show after 30 seconds

### Input/Output (stdin/stdout)
- [ ] Input field accepts multi-line text
- [ ] Code receives input from stdin field
- [ ] Output displays combined input prompts and results
- [ ] Input field can be cleared
- [ ] Placeholder text visible when empty

### Performance
- [ ] Simple code runs in <2 seconds
- [ ] Complex code runs in <30 seconds
- [ ] No UI freezing during execution
- [ ] Loading indicator shows while running

### All Languages
- [ ] Python code executes
- [ ] Java code executes
- [ ] C++ code executes
- [ ] Language switching works smoothly
- [ ] Each language shows correct compiler info

---

## Troubleshooting

### Issue: Output not showing at all
**Solution:**
1. Check browser console for errors
2. Look for "🔍 API Response Debug:" messages
3. Verify internet connection
4. Try simple test code: `print("test")`
5. Check if Wandbox API is accessible

### Issue: Only error appears, no successful output
**Solution:**
1. Verify code syntax is correct
2. Check if language selection matches code
3. Review code for undefined variables/functions
4. Try from code snippets library (use hamburger menu)

### Issue: Input/stdin not working
**Solution:**
1. Fill input field BEFORE clicking Run
2. For Python: use `input()` function, not command line args
3. For Java: use `Scanner` class
4. For C++: use `cin` for input
5. Separate multiple lines with newline (Enter key)

### Issue: Timeout on valid code
**Solution:**
1. Simplify code (remove infinite loops)
2. Reduce computation complexity
3. Check for blocking I/O operations
4. Test with simpler version first

---

## Debug Console Output

When testing, check the Flutter console for debug messages:

```
🔍 API Response Debug:
  Status: 0
  Program Output: Hello from CodeXecute!
  Compiler Error: 
  Program Error: 
```

This indicates:
- **Status: 0** = Success
- **Program Output** = What the code printed
- **Compiler Error** = Compilation issues (if any)
- **Program Error** = Runtime issues (if any)

---

## Expected Behavior Summary

| Scenario | Output Color | Shows | Time |
|----------|-------------|-------|------|
| Successful execution | Green ✅ | Program output | < 5s |
| Syntax error | Red ❌ | Error message | < 2s |
| Compile error | Red ❌ | Error with line | < 5s |
| Runtime error | Red ❌ | Error message | < 5s |
| No output code | Green ✅ | Placeholder | < 5s |
| Long output | Green ✅ | Full scrollable output | < 10s |
| Timeout | Red ❌ | "Timeout" message | 30s |

---

## Success Criteria

All of these should be true to confirm fixes are working:

1. ✅ Python code executes and shows green output
2. ✅ Java code executes and shows green output
3. ✅ C++ code executes and shows green output
4. ✅ Errors display in red with helpful messages
5. ✅ Input/stdin works for all languages
6. ✅ Long outputs don't get truncated
7. ✅ Output text can be selected/copied
8. ✅ Execution time displays correctly
9. ✅ No UI freezing during execution
10. ✅ Network errors handled gracefully

---

## Notes

- **API Used:** Wandbox (https://wandbox.org)
- **Timeout:** 30 seconds per execution
- **Execution:** Remote on Wandbox servers
- **Version:** Python 3.x, Java 22+, GCC Latest

🎉 When all tests pass, the output display fixes are confirmed working!
