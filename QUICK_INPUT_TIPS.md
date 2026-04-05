# 🚀 CodeXecute - Quick Input Tips Card

## 📥 Using the Input Field

### Where is it?
Look for **"📥 Input"** section - it's right above the Output area!

### How to use it?
1. Type your input in the text field
2. For multiple values, press **Enter** after each one
3. Click **"Run Code"** button
4. Your code receives the input via stdin

---

## ⚡ 30-Second Examples

### Python - Read Number & Double It
```
Code: print(int(input()) * 2)
Input: 5
Output: 10
```

### Java - Add Two Numbers  
```
Code:
  Scanner sc = new Scanner(System.in);
  System.out.println(sc.nextInt() + sc.nextInt());
  
Input:
  10
  20
Output: 30
```

### C++ - Check Even/Odd
```
Code:
  int n; cin >> n;
  cout << (n % 2 == 0 ? "Even" : "Odd");
  
Input: 7
Output: Odd
```

---

## ✅ Checklist Before Running

- [ ] Input field has data (if code needs it)
- [ ] Multiple inputs are on separate lines
- [ ] No blank lines at the end
- [ ] Data type matches (number → number input)
- [ ] Language selection is correct

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Input not working | Make sure input is entered BEFORE clicking Run |
| Type error | Check if code expects number vs. text |
| No output | Code might be waiting for input - fill input field |
| Runtime error | Verify input values and code syntax |

---

## 💡 Pro Tips

✨ **Tip 1:** Each line in input field = one separate input value  
✨ **Tip 2:** Python uses `input()`, Java uses `Scanner`, C++ uses `cin`  
✨ **Tip 3:** Copy test inputs from the **Code Snippets** - they're pre-tested!  
✨ **Tip 4:** Check console debug logs if something goes wrong  

---

## 🔗 Learn More

- **Full Guide:** See `INPUT_GUIDE.md` in project
- **Examples:** Check `Code Snippets` with input examples
- **Errors:** Debug console shows detailed API responses

---

**Ready to test?**  
Try this simple Python code with input `your_name`:
```python
name = input("Name: ")
print(f"Hello {name}!")
```
✨ Done! You're using stdin input now!
