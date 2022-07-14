About
---

Better debuggin makes it so that you can easily debug structs, arrays, variables, and more in a way that will show the data in a more cohesive way. 

How to use
---

There are 3 functions included that make debugging much more readable and gives you more control. 
- **log()**
- **print()**
- **breakpoint()**

With these 3 functions you can input nearly any game maker data into them and get a more readable outcome!

log(value)
---

`log()` will only return a string. This could be useful for drawing text in-game or whatever! `log` is the 'parser' so to speak and is used in conjunction with the other functions

print(value)
---

`print()` will show the `log` string in the debug console. It is just a wrapper for `show_debug_message()`.

breakpoint(value)
---

`breakpoint()` will show a message of the logged string. It is just a wrapper for `show_message()`

![Capture](https://user-images.githubusercontent.com/25496262/179066048-0192a108-b27c-42e4-9167-004052d365fb.PNG)
![Capture2](https://user-images.githubusercontent.com/25496262/179065967-93d417ed-b030-437c-9ec1-3e69f85a1d64.PNG)
