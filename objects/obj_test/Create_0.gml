function test_struct() constructor{
    name = ["Gizmo", "199"];
    age  = 30;
	
	// add a break point. will show only name and age
	breakpoint(self);	
	
    clothes = {
        shirt   : "plain",
        pants   : "jeans",
        hat     : "none"
    }
	
	some_func = function(){
		age -= 10;
		breakpoint(self);
	}
}

object= new test_struct();
tolog = "";