// Code snippets and examples for different programming languages
class CodeSnippets {
  // Python snippets
  static const Map<String, String> pythonSnippets = {
    'Hello World': '''print("Hello, World!")''',
    'Basic Input': '''name = input("Enter your name: ")
print(f"Hello, {name}!")''',
    'Loop Example': '''for i in range(1, 6):
    print(f"Number: {i}")''',
    'List Operations': '''numbers = [1, 2, 3, 4, 5]
print(f"Sum: {sum(numbers)}")
print(f"Max: {max(numbers)}")
print(f"Avg: {sum(numbers) / len(numbers)}")''',
    'Function': '''def greet(name):
    return f"Hello, {name}!"

print(greet("CodeXecute"))''',
    'Class Example': '''class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def info(self):
        return f"{self.name} is {self.age} years old"

p = Person("Alice", 25)
print(p.info())''',
    'File I/O': '''# Reading and writing
content = "Hello from file"
# Writing would normally use: open('file.txt', 'w').write(content)
print(content)''',
    'Exception Handling': '''try:
    result = 10 / 2
    print(f"Result: {result}")
except ZeroDivisionError:
    print("Cannot divide by zero!")
finally:
    print("Operation complete")''',
  };

  // Java snippets
  static const Map<String, String> javaSnippets = {
    'Hello World': '''public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}''',
    'Variables': '''public class Main {
    public static void main(String[] args) {
        int age = 25;
        String name = "Alice";
        double salary = 50000.0;
        System.out.println(name + " is " + age);
    }
}''',
    'Loop': '''public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            System.out.println("Number: " + i);
        }
    }
}''',
    'Array': '''public class Main {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        System.out.println("Sum: " + sum);
    }
}''',
    'Method': '''public class Main {
    static int add(int a, int b) {
        return a + b;
    }
    
    public static void main(String[] args) {
        System.out.println("Sum: " + add(5, 3));
    }
}''',
    'Class': '''public class Person {
    String name;
    int age;
    
    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    void display() {
        System.out.println(name + " is " + age);
    }
}

public class Main {
    public static void main(String[] args) {
        Person p = new Person("Bob", 30);
        p.display();
    }
}''',
    'Try-Catch': '''public class Main {
    public static void main(String[] args) {
        try {
            int result = 10 / 2;
            System.out.println("Result: " + result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}''',
    'ArrayList': '''import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(2);
        list.add(3);
        System.out.println("List: " + list);
    }
}''',
  };

  // C++ snippets
  static const Map<String, String> cppSnippets = {
    'Hello World': '''#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}''',
    'Variables': '''#include <iostream>
using namespace std;

int main() {
    int age = 25;
    string name = "Alice";
    double height = 5.8;
    cout << name << " is " << age << " years old" << endl;
    return 0;
}''',
    'Loop': '''#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 5; i++) {
        cout << "Number: " << i << endl;
    }
    return 0;
}''',
    'Array': '''#include <iostream>
using namespace std;

int main() {
    int arr[] = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int i = 0; i < 5; i++) {
        sum += arr[i];
    }
    cout << "Sum: " << sum << endl;
    return 0;
}''',
    'Function': '''#include <iostream>
using namespace std;

int add(int a, int b) {
    return a + b;
}

int main() {
    cout << "Sum: " << add(5, 3) << endl;
    return 0;
}''',
    'Struct': '''#include <iostream>
using namespace std;

struct Person {
    string name;
    int age;
};

int main() {
    Person p;
    p.name = "Charlie";
    p.age = 28;
    cout << p.name << " is " << p.age << endl;
    return 0;
}''',
    'Vector': '''#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> vec = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int num : vec) {
        sum += num;
    }
    cout << "Sum: " << sum << endl;
    return 0;
}''',
    'Sorting': '''#include <iostream>
#include <algorithm>
using namespace std;

int main() {
    vector<int> vec = {5, 2, 8, 1, 9};
    sort(vec.begin(), vec.end());
    cout << "Sorted: ";
    for (int num : vec) cout << num << " ";
    return 0;
}''',
  };

  // Get snippets for language
  static Map<String, String> getSnippets(String language) {
    switch (language) {
      case 'Python':
        return pythonSnippets;
      case 'Java':
        return javaSnippets;
      case 'C++':
        return cppSnippets;
      default:
        return {};
    }
  }

  // Get all available snippet names for language
  static List<String> getSnippetNames(String language) {
    return getSnippets(language).keys.toList();
  }
}
