function print(value){
    show_debug_message(log(value));
}
function breakpoint(value){
    show_message("BREAKPOINT\n"+log(value));
}
function log(value, indenting = 0){
    var spacing =   "       ";
    var indent  =   indenting;
    var text    =   "";

    // Data
    switch(typeof(value)){
        case "struct"   : 
            var struct = value;
            var base = "";
            repeat(indent) base += spacing;
            var idt = base + spacing;
            
            text += base + "{\n";
            var key = variable_struct_get_names(value);
            len = variable_struct_names_count(value);
            
            for ( var i=0; i<array_length(key); i++ ){
                var name = key[i];
                var val  = struct[$ name];
    
                text += idt+name + " : "
                switch(typeof(val)){
                    case "struct"   : text += "\n"+log(val, indent+1); break;
                    case "array"    : text += "["+ log(val, indent); break;
                    case "string"   : text += val; break;
                    case "number"   : text += string(val); break;
                    case "method"   : text += "function"; break;
                    case "bool"     : text += ( val ) ? "true" : "false"; break;
                    case "undefined": text += "undefined"; break;
                }
                text += (i != len-1 ) ? ",\n" : "\n";
            }
            text += base + "}";
        break;
        case "array"    : 
            var array = value;
            var len  = array_length(array);
            var idt  = ""; repeat(indent) idt += spacing;
            text += idt;
            
            for ( var i=0; i<len; i++ ){
                
                value = array[i];
                switch(typeof(value)){
                    case "struct"   : text += "\n"+ log(value, indent+1); break;
                    case "array"    : text += "[" + log(value, indent+1); break;
                    case "string"   : text += value; break;
                    case "number"   : text += string(value); break;
                    case "method"   : text += "function"; break;
                    case "bool"     : text += ( value ) ? "true" : "false"; break;
                    case "undefined": text += "undefined"; break;
                }
                text += (i != len-1) ? ", " : "";
            }
            text +="]\n";
        break;
        case "string"   : text += value; break;
        case "number"   : text += string(value); break;
        case "method"   : text += "function"; break;
        case "bool"     : text +=  ( value ) ? "true" : "false"; break;
        case "undefined": text += "undefined"; break;
    }
    return text;
}