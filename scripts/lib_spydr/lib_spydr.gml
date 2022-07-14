#region Default Configs

    #macro SPYDR_INDENT             "       "				// How far to indent for sub-structs and data
    #macro SPYDR_LINEBREAK          "^"						// This is used for linebreaks in strings.
    #macro SPYDR_TYPE_OPEN          "<"						// This is the 'open' indicator for text coloring
    #macro SPYDR_TYPE_CLOSE         ">"						// this is the 'close' indicator for text coloring
    #macro SPYDR_DEFAULT            "<def>"					// this is used to define the default color
    
    #macro SPYDR_COLOR_DEFAULT		c_white					// default text color
    #macro SPYDR_COLOR_STRUCT       c_fuchsia				// color of struct variables
    #macro SPYDR_COLOR_ARRAY        c_ltgray				// color of array variables
    #macro SPYDR_COLOR_STRING       c_aqua					// color of string variables
    #macro SPYDR_COLOR_UNDEF        c_purple				// color of undefined variables
    #macro SPYDR_COLOR_METHOD       c_red					// color of function and method variables
    #macro SPYDR_COLOR_BOOLEAN      c_orange				// color of boolean variables
    #macro SPYDR_COLOR_NUMBER       c_yellow				// color of number variables
    
#endregion
#region Console Constructor

    function spydr_console() constructor{
        
        // basic setup
        x = 0;
        y = 0;
        callstack_enable = false;
        callstack_depth = 10;
        main_log = "";
        
        // call stack ban words
        banlist     = [
            "anon", 
            "gml", 
            "GlobalScript", 
            "Script", 
            "Object", 
            "lib_spydr", 
            //"spydr_console",
        ];
        
        // Default settings
        indention   = SPYDR_INDENT;
        linebreak   = SPYDR_LINEBREAK;
        type_open   = SPYDR_TYPE_OPEN;
        type_close  = SPYDR_TYPE_CLOSE;
        set_default = SPYDR_DEFAULT;
        
        color = {
            def     : SPYDR_COLOR_DEFAULT,
            struct  : SPYDR_COLOR_STRUCT,
            array   : SPYDR_COLOR_ARRAY,
            str     : SPYDR_COLOR_STRING,
            undef   : SPYDR_COLOR_UNDEF,
            func    : SPYDR_COLOR_METHOD,
            boolean : SPYDR_COLOR_BOOLEAN,
            number  : SPYDR_COLOR_NUMBER
        }
        
        // Funtions
        cleanup_log = function(text){
            for ( var i=0; i<array_length(banlist); i++ ){
                text = string_replace_all(text, banlist[i], "");
            }
            return text;
        }
        
        enable_callstack = function(enabled){
            callstack_enable = enabled;
        }
        log_callstack = function(){
            var t = "";
            var c = debug_get_callstack(callstack_depth);
            
            t = "Spydr callstack\n";
            for ( var i=0; i<array_length(c)-1; i++ ) t+="call "+string(i)+" ["+string(c[i])+"\n";
            t = string_replace_all(t, ":", "] line: ");
            t = cleanup_log(t);
            t += "\n";
            return t;
        }
        print = function(value){
            var l = log(value);
            var t = callstack_enable ? log_callstack() : "";
            var text = t + l;
            
            main_log = l;
            text = string_replace_all(text, linebreak, "\n");
            text = string_replace_all(text, set_default, "");
            show_debug_message(text);   
        }
        breakpoint = function(value){
            var l = log(value);
            var t = callstack_enable ? log_callstack() : "";
        	var text = t + l; 
        	
        	main_log = l;
            text = string_replace_all(text, linebreak, "\n");
            text = string_replace_all(text, set_default, "");
            show_message(text);
        }
        log = function(value, indent = 0){
            var spacing =   indention;
            var text    =   "";
        
            switch(typeof(value)){
                case "struct"   : 
                    var struct = value;
                    var base = "";
                    repeat(indent) base += indention;
                    var idt = base + indention;
                    
                    text += base + set_default + "{"+linebreak;
                    var key = variable_struct_get_names(value);
                    var len = variable_struct_names_count(value);
                    
                    for ( var i=0; i<len; i++ ){
                        var name = key[i];
                        var val  = struct[$ name];
                        
                        // Add text
                        var type = typeof(val);
                        var prfx = type_open+type+type_close;
                        text += idt+prfx+name +" : "
                        
                        switch(type){
                            case "bool"     : text += ( val ) ? "true" : "false"; break;
                            case "struct"   : text += linebreak+log(val, indent+1); break;
                            case "array"    : text += "["+ log(val, indent); break;
                            case "undefined": text += "undefined"; break;
                            case "number"   : text += string(val); break;
                            case "method"   : text += "function"; break;
                            case "string"   : text += val; break;
                        }
                        text += set_default;
                        
                        // Endings
                        var add = "";
                        if ( i != len-1 ) add = ","+linebreak;
                        else add = linebreak;
                        text += add;
                    }
                    text += base + "}";
                break;
                case "array"    : 
                    var array = value;
                    var len  = array_length(array);
                    var idt  = ""; repeat(indent) idt += indention;
                    text += idt;
                    
                    for ( var i=0; i<len; i++ ){
                        
                        // Add text
                        var val = array[i];
                        var type = typeof(val);
                        
                        var prfx = type_open+type+type_close;
                        text += prfx;
                        
                        switch(type){
                            case "bool"     : text += ( val ) ? "true" : "false"; break;
                            case "struct"   : text += "^"+ log(val, indent+1); break;
                            case "array"    : text += log(val, indent+1); break;
                            case "number"   : text += string(val); break;
                            case "undefined": text += "undefined"; break;
                            case "method"   : text += "function"; break;
                            case "string"   : text += val; break;
                        }
                        text += set_default;
                        
                        // Endings
                        var add = "";
                        if ( i != len-1 ) add = ",";
                        else if ( indent == 0 ) add = "";
                        else add = linebreak;
                        text += add;
                    }
                    text +="]";
                break;
                case "method"   : 
                    
                    text += "function";
                    
                break;
                case "bool"     : text += ( value ) ? "true" : "false"; break;
                case "number"   : text += string(value); break;
                case "undefined": text += "undefined"; break;
                case "string"   : text += value; break;
            }
            
            // Return string
            return text;
        }
        draw = function(){
            var col = color.def;
            var w = 0;
            var h = 0;
            
            var _log = main_log;
            var ltxt = "<struct> struct, <method> method, <array> array, <string> string, <number> number, <bool> boolean, <undefined> undefined^^";
            _log = ltxt+_log;
            
            for ( var i=1; i<string_length(_log)+1; i++){
                var text = "";
                var char = string_char_at(_log, i);
                
                var t = "";
                if ( char == type_open && string_char_at(_log, i+1) != " " ){
                    var t = "";
                    var j = 0;
                    repeat(20){
                        var c = string_char_at(_log, i+1+j);
                        if ( c == type_close ) {j++; break;}
                        t += c;
                        j++;
                    }
                    i += j;
                    w--;
                    switch(t){
                        case "struct": col      = color.struct;     break;
                        case "method": col      = color.func;       break;
                        case "array": col       = color.array;      break;
                        case "string": col      = color.str;        break;
                        case "number": col      = color.number;     break;
                        case "bool": col        = color.boolean;    break;
                        case "undefined": col   = color.undef;      break;
                        default: col            = color.def;
                    }
                    draw_set_color(col);
                } else text += char;
                
                w++;
                if ( char == linebreak ){
                    h+=1;
                    w=0;
                }
                draw_text(x + (w*8), y + (h * 16), string_replace_all(text, linebreak, ""));
            }
            draw_set_color(color.def);
            }
    }
    
#endregion

//Main console
#macro spydr global._spydr_console
spydr = new spydr_console();

// Separae functions
#macro spydr_enable_callstack spydr.enable_callstack
#macro spydr_print      spydr.print
#macro spydr_breakpoint spydr.breakpoint
#macro spydr_log        spydr.log
#macro spydr_draw       global._drawfunc
spydr_draw = function(_x, _y){
    spydr.x = _x;
    spydr.y = _y;
    spydr.draw();
}