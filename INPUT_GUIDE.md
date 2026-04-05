# 📥 User Input (stdin) Guide for CodeXecute

## How to Use the Input Field

The **Input** section lets you provide data to your code via stdin (standard input). Here's how:

### 📍 Where to Enter Input
1. Look for the **"📥 Input"** section above the Output area
2. Click in the text field that says "Enter input data here"
3. Type your input data
4. For multiple inputs, press **Enter** to create new lines
5. Click **Run Code** button

---

## 🐍 Python - Getting User Input

### Code Example:
```python
# Single input
name = input("Enter your name: ")
print(f"Hello, {name}!")
```

**Input field should contain:**
```
John
```

**Output:**
```
Enter your name: Hello, John!
```

---

### Multiple Inputs in Python:
```python
# Multiple separate inputs
name = input("Enter name: ")
age = input("Enter age: ")
city = input("Enter city: ")
print(f"{name}, {age}, {city}")
```

**Input field should contain (one per line):**
```
Alice
25
New York
```

**Output:**
```
Enter name: Enter age: Enter city: Alice, 25, New York
```

---

## ☕ Java - Getting User Input

### Using Scanner:
```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a number: ");
        int num = sc.nextInt();
        System.out.println("Number is: " + num);
    }
}
```

**Input field should contain:**
```
42
```

**Output:**
```
Enter a number:
Number is: 42
```

---

### Multiple Inputs in Java:
```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String name = sc.nextLine();
        int age = sc.nextInt();
        System.out.println(name + " is " + age + " years old");
    }
}
```

**Input field (press Enter between lines):**
```
Alice
25
```

**Output:**
```
Alice is 25 years old
```

---

## ⚡ C++ - Getting User Input

### Using cin:
```cpp
#include <iostream>
using namespace std;

int main() {
    int num;
    cout << "Enter a number: ";
    cin >> num;
    
    if(num % 2 == 0)
        cout << "Even";
    else
        cout << "Odd";
    
    return 0;
}
```

**Input field should contain:**
```
42
```

**Output:**
```
Enter a number: Even
```

---

### Multiple Inputs in C++:
```cpp
#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << "Sum: " << (a + b) << endl;
    cout << "Product: " << (a * b) << endl;
    return 0;
}
```

**Input field (space or newline separated):**
```
10
20
```

**Output:**
```
Sum: 30
Product: 200
```

---

### Reading Entire Lines in C++:
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    getline(cin, name);
    cout << "Your name: " << name << endl;
    return 0;
}
```

**Input field:**
```
John Doe
```

**Output:**
```
Your name: John Doe
```

---

## ⚠️ Common Input Issues & Solutions

### Issue 1: Code Runs But No Output
**Reason:** Code is waiting for input but input field is empty  
**Solution:** 
1. Fill the input field BEFORE clicking Run Code
2. Make sure input values match what code expects

### Issue 2: "ERROR: failed to exec pidi"
**Reason:** Input format or buffering issue  
**Solution:**
1. Ensure each input is on a separate line
2. Remove extra spaces or blank lines
3. Make sure input types match (int vs. string)

### Issue 3: Wrong Type Error
**Reason:** Trying to read int but input is text  
**Solution ✅:**
```
Python: input() always returns string
Java: Use sc.nextInt() for int, nextLine() for string
C++: cin >> for int/double, getline() for string
```

### Issue 4: Input Not Recognized
**Reason:** Input field not properly connected  
**Solution:**
1. Look for info message: "Input will be passed to your code via stdin"
2. Check console for debug: "📤 Sending Request to Wandbox"
3. Verify stdinfmessage shows your input data

---

## 🧪 Test Cases

### Test 1: Basic Single Input (Any Language)

**Python:**
```python
num = int(input())
print(num * 2)
```

**Input:**
```
5
```

**Expected Output:**
```
10
```

---

### Test 2: Multiple Inputs (Any Language)

**C++:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b >> c;
    cout << a + b + c << endl;
    return 0;
}
```

**Input:**
```
1
2
3
```

**Expected Output:**
```
6
```

---

### Test 3: String Input

**Java:**
```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String word = sc.nextLine();
        System.out.println("Length: " + word.length());
    }
}
```

**Input:**
```
Hello
```

**Expected Output:**
```
Length: 5
```

---

### Test 4: Conditional Input

**Python:**
```python
age = int(input())
if age >= 18:
    print("Adult")
else:
    print("Minor")
```

**Input:**
```
20
```

**Expected Output:**
```
Adult
```

---

## 🔍 Debug Console Output

When you run code with input, check the Flutter console for:

```
📤 Sending Request to Wandbox:
  Compiler: cpython-head
  Stdin provided: true
  Stdin data: "5"
  Formatted stdin: "5\n"

🔍 API Response Debug:
  Status: 0
  Program Output: 10
  Compiler Error: 
  Program Error: 
```

This confirms your input was sent correctly! ✅

---

## 💡 Pro Tips

1. **Extra line break:** Input field automatically adds newline if missing
2. **Multiple inputs:** Each line = one separate input value
3. **Integer input:** Works the same across all languages
4. **String input:** Use `nextLine()` in Java, `getline()` in C++, `input()` in Python
5. **Test first:** Try simple input code before complex logic

---

## 🚀 Quick Reference

| Language | Single Int | Single String | Multiple Values |
|----------|-----------|--------------|-----------------|
| Python | `int(input())` | `input()` | `int(input()), input()` |
| Java | `sc.nextInt()` | `sc.nextLine()` | `sc.nextInt(), sc.nextLine()` |
| C++ | `cin >> num` | `getline(cin, str)` | `cin >> a >> b >> c` |

---

## ✅ Verification Checklist

Before clicking Run Code:
- [ ] Input field has data (if code needs input)
- [ ] Input values are correct type
- [ ] Multiple inputs are on separate lines
- [ ] No extra blank lines at end
- [ ] Code handles input correctly

After clicking Run Code:
- [ ] Output appears in green
- [ ] Execution time displays
- [ ] Input was processed correctly
- [ ] No "Runtime Error" message

---

**Pro Tip:** If input still doesn't work, copy the code from "Code Snippets" library - all examples are pre-tested with inputs! 🎯
