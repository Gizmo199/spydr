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

![Capture](https://user-images.githubusercontent.com/25496262/179073091-0222b5cd-233f-4ebf-a598-1ce9ea3809cd.PNG)
![Capture2](https://user-images.githubusercontent.com/25496262/179073094-b7ce9f48-9d29-4a30-a66e-ee147c761d80.PNG)
