{
    open Parser
    let indentstack = Stack.create()
}


let linestart = ^(' '*|'\t'*)
let spacetab = ' '*|'\t'*
let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let id = ('_'|letter) (letter|digit|'_')*
let exp = 'e'('+'|'-')?['0'-'9']+
let num = '-'? (digit)+ ('.'? (digit)* exp?|exp)

rule token = parse
    
    linestart as lxm               { indent (Lexing.from_string lxm) }
    | '#'                   { comment lexbuf }
    | '='                   { ASSIGN }
    | id as lxm             { ID(lxm) }
    | num as lxm            { NUM(float_of_string lxm) }
    | ['\r' '\n' ' ' '\t']  { token lexbuf }
    | eof                   { EOF }
    | _ as char             { raise (Failure("SCANNER: illegal input"^Char.escaped char)) }

and indent = parse
    | spacetab as s
      {
        if(Stack.is_empty indentstack) then (
            print_endline "lalala";
            if (String.length s) > 0 then begin
                Stack.push (String.length s) indentstack;
                INDENT
            end
            else
                token lexbuf
        )
        else
        if String.length s = (Stack.top indentstack) then begin
        
            Stack.pop indentstack;
            token lexbuf
        end
        else if String.length s > (Stack.top indentstack) then begin
                
                    Stack.push (String.length s) indentstack; 
                    INDENT
             end
             else (
                Stack.pop indentstack;
                if( String.length s > (Stack.top indentstack) ) then begin
                    raise (Failure("SCANNER: illegal indent")) 
                end
                else 
                    lexbuf = Lexing.from_string ("^" ^ (Lexing.lexeme lexbuf));
                    DEDENT
                )
                
             
         }
        
and comment = parse
    '\n' { token lexbuf }
    | _    { comment lexbuf }

