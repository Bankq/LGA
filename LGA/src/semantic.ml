open Ast
let float_of_expr : expr -> float = function
  | Num(x) -> x
  | _ -> 0.0
              
let string_of_expr : expr -> string = function
  | Id(x) -> x
  | _ -> "fuck"

let rec eval  = function 
  | Id(x) ->
     Printf.printf "Got ID: %s\n" x;
     Id x
  | Num(x) ->
     Printf.printf "Got Num: %f\n" x;
     Num x
  | Assign(x, y) ->
     let id = eval x in 
     let num = eval y in
     Id (Printf.sprintf "%s is asssigned to %f\n" (string_of_expr id) (float_of_expr num))

let _ = 
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.token lexbuf in 
  let result = eval expr in
  print_endline (string_of_expr result)


