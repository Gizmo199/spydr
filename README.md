About
===

Spydr makes it so that you can easily debug structs, arrays, variables, and more in a way that will show the data in a more cohesive way. 

How to use
===

There are 3 functions included that make debugging much more readable and gives you more control. 
- **spydr.log()**
- **spydr.print()**
- **spydr.breakpoint()**

With these 3 functions you can input nearly any game maker data into them and get a more readable outcome!

spydr.log(value)
---

`spydr.log()` will only return a string. This could be useful for drawing text in-game or whatever! `log` is the 'parser' so to speak and is used in conjunction with the other functions. You can also call this function using `spydr_log(value)`

spydr.print(value)
---

`spydr.print()` will show the `log` string in the debug console. It is just a wrapper for `show_debug_message()`. You can also call this function using `spydr_print(value)`

spydr.breakpoint(value)
---

`spydr.breakpoint()` will show a message of the logged string. It is just a wrapper for `show_message()`. You can also call this function using `spydr_breakpoint(value)`

spydr.draw()
---
This will draw the spydr debug console. You can change the position by setting `spydr.x` or `spydr.y` wherever you want. You can also call this function using `spydr_draw(x, y)`

spydr.enable_callstack()
---
This will enable spydr to also show the callstack before the value being debugged. It will look something like this:
```
Spydr callstack
call 0 [___spydr_console____2638_spydr_console___] line: 72
call 1 [___spydr_console____3051_spydr_console___] line: 83
call 2 [__obj_test_KeyPress_32] line: 3
```

![Capture2](https://user-images.githubusercontent.com/25496262/179077706-a36c4ec8-5642-4752-9414-a31ee432673c.PNG)
![Capture](https://user-images.githubusercontent.com/25496262/179077716-3d6cc4fa-e1b1-4c11-8866-f4686e8e54f6.PNG)

