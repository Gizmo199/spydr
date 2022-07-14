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

![Capture](https://user-images.githubusercontent.com/25496262/179071494-a59c09b4-73f8-4eb9-8758-54efa56b64e3.PNG)
![Capture2](https://user-images.githubusercontent.com/25496262/179071502-4297a6e1-01ff-403a-851f-b0422796d414.PNG)
