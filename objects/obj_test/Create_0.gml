spydr_enable_callstack(true);
function test_struct() constructor{
    name = ["Gizmo", "199"];
    age  = 30;
	
	// add a break point. will show only name and age
	spydr.breakpoint(self);	
	
    clothes = {
        shirt   : "plain",
        pants   : "jeans",
        hat     : "none"
    }
	
	some_func = function(){
		age -= 10;
		spydr.breakpoint(self);
	}
}

object= new test_struct();
tolog = "";