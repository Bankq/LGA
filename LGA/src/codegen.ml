open Lga
open Ast
open Parser
open Semantic


let print_fun_body a = 
  match a with
  | FunctionBody(x, y) ->
     String.concat "" ["function (";
                       (String.concat ", " x);
                       ") {";
                       y;"}"]

let print_top_fun a = 
  match a with
  | TopFun(x, y) ->
     print_endline (String.concat " " ["var";x;"=";print_fun_body y])

let test a =
    match a with
     | Ignore -> print_endline "IGNORE"
     | FunVar_lga(x) -> 
        print_top_fun x
     | ObjVar_lga(x) -> print_endline "Object"
     | _ -> print_endline "HAHAH"

let _ = 
  let filename = Sys.argv.(1) in
  let lga = lga_of_file filename in
  List.map test lga
