function print(value){
    show_debug_message(log(value));
}
function breakpoint(value){
    show_message("BREAKPOINT\n\n"+log(value));
}
function log(value, indenting = 0){
    var spacing =   "       ";
    var indent  =   indenting;
    var text    =   "";
    
    switch(typeof(value)){
        case "struct"   : 
            var struct = value;
            var base = "";
            repeat(indent) base += spacing;
            var idt = base + spacing;
            
            text += base + "{\n";
            var key = variable_struct_get_names(value);
            var len = variable_struct_names_count(value);
            
            for ( var i=0; i<len; i++ ){
                var name = key[i];
                var val  = struct[$ name];
                
                // Add text
                text += idt+name + " : "
                switch(typeof(val)){
                    case "bool"     : text += ( val ) ? "true" : "false"; break;
                    case "struct"   : text += "\n"+log(val, indent+1); break;
                    case "array"    : text += "["+ log(val, indent); break;
                    case "undefined": text += "undefined"; break;
                    case "number"   : text += string(val); break;
                    case "method"   : text += "function"; break;
                    case "string"   : text += val; break;
                }
                
                // Endings
                var add = "";
                if ( i != len-1 ) add = ",\n";
                else if ( indent == 0 ) add = "";
                else add = "\n";
                text += add;
            }
            text += base + "}";
        break;
        case "array"    : 
            var array = value;
            var len  = array_length(array);
            var idt  = ""; repeat(indent) idt += spacing;
            text += idt;
            
            for ( var i=0; i<len; i++ ){
                
                // Add text
                value = array[i];
                switch(typeof(value)){
                    case "bool"     : text += ( value ) ? "true" : "false"; break;
                    case "struct"   : text += "\n"+ log(value, indent+1); break;
                    case "array"    : text += "[" + log(value, indent+1); break;
                    case "number"   : text += string(value); break;
                    case "undefined": text += "undefined"; break;
                    case "method"   : text += "function"; break;
                    case "string"   : text += value; break;
                }
                
                // Endings
                var add = "";
                if ( i != len-1 ) add = ", ";
                else if ( indent == 0 ) add = "";
                else add = "\n";
                text += add;
            }
            text +="]\n";
        break;
        case "bool"     : text += ( value ) ? "true" : "false"; break;
        case "number"   : text += string(value); break;
        case "undefined": text += "undefined"; break;
        case "method"   : text += "function"; break;
        case "string"   : text += value; break;
    }
    
    // Return string
    return text;
}