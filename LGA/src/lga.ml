open Ast

let rec eval = function
  | Id(x) ->
     Printf.printf "Got ID: %s\n" x;
     x
  | Num(x) ->
     Printf.printf "Got Num: %f\n" x;
     string_of_float x
  | Assign(x, y) ->
     Printf.printf "fuck\n";
     let id = eval x in
     let num = eval y in
     print_endline "Fuck";
     " Me"
                   


let _ = 
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.token lexbuf in 
  let result = eval expr in
  print_endline result


