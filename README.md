About
===

Spydr makes it so that you can easily debug structs, arrays, variables, and more in a way that will show the data in a more cohesive way. 

How to use
===

There are 5 functions included that make debugging much more readable and gives you more control. You only need to call `spydr` and then:
- **.log()**
- **.print()**
- **.breakpoint()**
- **.draw()**
- **.enable_callstack()**
- **.enable_add_logging()**

With these 5 functions you can input nearly any game maker data into them and get a more readable outcome! For example you can easily print the contents of a struct by typing `spydr.print(my_struct)`.

.log(value)
---

`spydr.log()` will only return a string. This could be useful for drawing text in-game or whatever! `log` is the 'parser' so to speak and is used in conjunction with the other functions. You can also call this function using `spydr_log(value)`

.print(value)
---

`spydr.print()` will show the `log` string in the debug console. It is just a wrapper for `show_debug_message()`. You can also call this function using `spydr_print(value)`

.breakpoint(value)
---

`spydr.breakpoint()` will show a message of the logged string. It is just a wrapper for `show_message()`. You can also call this function using `spydr_breakpoint(value)`

.draw()
---
This will draw the spydr debug console at the bottom of the screen. 


.enable_callstack()
---
This will enable spydr to also show the callstack before the value being debugged. It will look something like this:
```
Spydr callstack
call 0 [___spydr_console____2638_spydr_console___] line: 72
call 1 [___spydr_console____3051_spydr_console___] line: 83
call 2 [__obj_test_KeyPress_32] line: 3
```

.enable_add_logging()
---
This will enable additive logging. This means that it will add new log information to the end of old log information (much like how Gamemakers current `show_debug_message()` works)

![Capture](https://user-images.githubusercontent.com/25496262/179115660-0a4e643b-3e12-4a78-83cf-8d75d979baf9.PNG)
![Capture2](https://user-images.githubusercontent.com/25496262/179115667-cf313d6b-8b39-4051-8f63-bed08faa0e38.PNG)

