function print(value){
    show_debug_message(log(value));
}
function breakpoint(value){
    show_message(value);
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

// function console() constructor {
    
//     log = function(value){
        
//         var text = "";
//         text = "[log : "
        
//         show_message(typeof(value));
        
//         // Data
//         switch(typeof(value)){
//             case "struct"   : text += "struct]\n "    + log_struct(value, 0)+"\n"; break;
//             case "array"    : text += "array]\n "     + log_array(value, 0); break;
//             case "string"   : text += "string]\n "    + value; break;
//             case "number"   : text += "number]\n "    + string(value); break;
//             case "method"   : text += "function]\n "  + "function"; break;
//             case "bool"     : text += "boolean]\n "   + ( value ) ? "true" : "false"; break;
//             case "undefined": text += "null]\n "      + "undefined"; break;
//         }
        
//         show_message(text);
//     }
//     log_array = function(array, indent){
//         var len  = array_length(array);
//         var idt  = ""; repeat(indent) idt += SPYDR_NESTED_SPACING;
//         var text = idt;
        
//         for ( var i=0; i<len; i++ ){
            
//             value = array[i];
//             switch(typeof(value)){
//                 case "struct"   : text += "{} = \n"+log_struct(value, indent+1)+"\n"; break;
//                 case "array"    : text += "[" + log_array(value, indent+1); break;
//                 case "string"   : text += value; break;
//                 case "number"   : text += string(value); break;
//                 case "method"   : text += "function"; break;
//                 case "bool"     : text += ( value ) ? "true" : "false"; break;
//                 case "undefined": text += "undefined"; break;
//             }
//             text += (i != len-1) ? ", " : "";
//         }
//         text +="]\n";
//         return text;
//     }
//     log_struct = function(struct, indent){
//         var base = "";
//         repeat(indent) base += SPYDR_NESTED_SPACING;
        
//         var text    = base + "{\n";
//         var idt     = base + SPYDR_NESTED_SPACING;
        
//         key = variable_struct_get_names(struct);
//         len = variable_struct_names_count(struct);
        
//         for ( var i=0; i<array_length(key); i++ ){
//             var name = key[i];
//             var value= struct[$ name];

//             text += idt+name + " : "
//             switch(typeof(value)){
//                 case "struct"   : text += "\n"+log_struct(value, indent+1); break;
//                 case "array"    : text += "["+log_array(value, indent); break;
//                 case "string"   : text += value; break;
//                 case "number"   : text += string(value); break;
//                 case "method"   : text += "function"; break;
//                 case "bool"     : text += ( value ) ? "true" : "false"; break;
//                 case "undefined": text += "undefined"; break;
//             }
//             text += (i != len-1 ) ? ",\n" : "\n";
//         }
//         text += base + "}";
//         return text;
//     }
// }