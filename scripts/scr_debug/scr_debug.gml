#region Configs
    
    #macro CALLSTACK_ENABLE     true
    #macro CALLSTACK_DEPTH      10
    
    #macro INDENTING            "       "
    #macro LINEBREAK            "^"
    #macro TYPE_OPEN            "<"
    #macro TYPE_CLOSE           ">"
    #macro SEPARATOR            "\n-----------------\n\n"
    
    #macro COLOR_DEFAULT        c_white
    #macro COLOR_STRUCT         c_fuchsia
    #macro COLOR_ARRAY          c_aqua
    #macro COLOR_STRING         c_aqua
    #macro COLOR_UNDEF          c_purple
    #macro COLOR_METHOD         c_red
    #macro COLOR_BOOLEAN        c_orange
    #macro COLOR_NUMBER         c_yellow

#endregion

function print(value){
	var l = log(value);
    var c = debug_get_callstack(CALLSTACK_DEPTH);
    var t = "";
    if ( CALLSTACK_ENABLE ) {
        for ( var i=0; i<array_length(c)-1; i++ ) t+="call "+string(i)+" ["+string(c[i])+"\n";
        t = string_replace_all(t, ":", "] line: ");
        t = string_replace_all(t, "gml_Object_", "");
        t = string_replace_all(t, "gml_Script_", "");
        t += SEPARATOR;
    }   
    show_debug_message(t+string_replace_all(l, LINEBREAK, "\n"));
}
function breakpoint(value){
    var l = log(value);
    var c = debug_get_callstack(CALLSTACK_DEPTH);
    var t = "";
    if ( CALLSTACK_ENABLE ){
        for ( var i=0; i<array_length(c)-1; i++ ) t+="call "+string(i)+" ["+string(c[i])+"\n";
        t = string_replace_all(t, ":", "] line: ");
        t = string_replace_all(t, "gml_Object_", "");
        t = string_replace_all(t, "gml_Script_", "");
        t = SEPARATOR + t + SEPARATOR;
    }
	show_message("BREAKPOINT\n"+t+string_replace_all(l, LINEBREAK, "\n"));
}
function log(value, indenting = 0){
    var spacing =   INDENTING;
    var indent  =   indenting;
    var text    =   "";

    switch(typeof(value)){
        case "struct"   : 
            var struct = value;
            var base = "";
            repeat(indent) base += INDENTING;
            var idt = base + INDENTING;
            
            text += base + "{"+LINEBREAK;
            var key = variable_struct_get_names(value);
            var len = variable_struct_names_count(value);
            
            for ( var i=0; i<len; i++ ){
                var name = key[i];
                var val  = struct[$ name];
                
                // Add text
                var type = typeof(val);
                var prfx = TYPE_OPEN+type+TYPE_CLOSE+" ";
                text += idt+prfx+name +" : "
                
                switch(type){
                    case "bool"     : text += ( val ) ? "true" : "false"; break;
                    case "struct"   : text += LINEBREAK+log(val, indent+1); break;
                    case "array"    : text += "["+ log(val, indent); break;
                    case "undefined": text += "undefined"; break;
                    case "number"   : text += string(val); break;
                    case "method"   : text += "function"; break;
                    case "string"   : text += val; break;
                }
                
                // Endings
                var add = "";
                if ( i != len-1 ) add = ","+LINEBREAK;
                else add = LINEBREAK;
                text += add;
            }
            text += base + "}";
        break;
        case "array"    : 
            var array = value;
            var len  = array_length(array);
            var idt  = ""; repeat(indent) idt += INDENTING;
            text += idt;
            
            for ( var i=0; i<len; i++ ){
                
                // Add text
                var val = array[i];
                var type = typeof(val);
                
                var prfx = TYPE_OPEN+type+TYPE_CLOSE+" ";
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
                
                // Endings
                var add = "";
                if ( i != len-1 ) add = ",";
                else if ( indent == 0 ) add = "";
                else add = LINEBREAK;
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
function draw_log(_x, _y, _log){
    
    var col = c_white;
    var w = 0;
    var h = 0;
    
    for ( var i=1; i<string_length(_log)+1; i++){
        var text = "";
        var char = string_char_at(_log, i);
        
        var t = "";
        if ( char == TYPE_OPEN && string_char_at(_log, i+1) != " " ){
            var t = "";
            var j = 0;
            repeat(20){
                var c = string_char_at(_log, i+1+j);
                if ( c == TYPE_CLOSE ) {j++; break;}
                t += c;
                j++;
            }
            i += j;
            w-=2;
            switch(t){
                case "struct": col      = COLOR_STRUCT; break;
                case "method": col      = COLOR_METHOD; break;
                case "array": col       = COLOR_ARRAY; break;
                case "string": col      = COLOR_STRING; break;
                case "number": col      = COLOR_NUMBER; break;
                case "bool": col        = COLOR_BOOLEAN; break;
                case "undefined": col   = COLOR_UNDEF; break;
                default: col            = COLOR_DEFAULT;
            }
            draw_set_color(col);
        } else text += char;
        
        w++;
        if ( char == LINEBREAK ){
            h+=1;
            w=0;
        }
        draw_text(_x + (w*8), _y + (h * 16), string_replace_all(text, LINEBREAK, ""));
    }
}