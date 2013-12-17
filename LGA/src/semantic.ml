open Printf
open Ast
open Lga
open Scanner
open Parser
open Utils


let handle_ignore () = 
  ""

(* let handle_op a =  *)
(*   log("OP") *)

let handle_literal a =
  match a with
  | Literal(x) -> x

let handle_identifier a =
  handle_literal a

(* let handle_index_value a = *)
(*   log("IndexValue"); *)
(*   handle_literal a *)

(* let handle_index a = *)
(*   match a with *)
(*   | Index(x) -> log("Index"); *)
(*                 handle_index_value x *)

(* let handle_accessor a =  *)
(*   match a with *)
(*   | DotAccessor(x) -> log("DotAccessor"); *)
(*                       handle_identifier x *)
(*   | IndexAccessor(x) -> log("IndexAccessor"); *)
(*                         handle_index x *)

(* let handle_arg_list f a = *)
(*   log("ArgList"); *)
(*   List.iter f a *)

(* let handle_array f a =  *)
(*   log("Array"); *)
(*   handle_arg_list f a *)

let handle_this_property a =
  "this."^(handle_identifier a)

let handle_obj_assignable a =
  match a with
  | IdentifierObjAssignable(x) ->
     handle_identifier x
  | ThisPropertyObjAssignable(x) ->
     handle_this_property x

(* let handle_assign_obj f a = *)
(*   match a with *)
(*   | AssignObj(x, y) -> *)
(*      Printf.printf "ASSIGN LEFT: %s\n" (handle_obj_assignable x); *)
(*      f y *)

(* let handle_assign_list f a =  *)
(*   log("AssignList"); *)
(*   List.iter (handle_assign_obj f) a *)

(* let handle_obj f a =  *)
(*   match a with *)
(*   | Object(x) -> log("Object"); *)
(*                  handle_assign_list f x *)

(* let handle_return f a = *)
(*   match a with *)
(*   | Return(x) -> log("Return"); *)
(*                  f x *)

(* let handle_statement f a = *)
(*   match a with *)
(*   | ReturnStatement(x) -> log("ReturnStatement"); *)
(*                           handle_return f x *)
(*   | LiteralStatement(x) -> log("LiteralStatement"); *)
(*                            handle_literal x *)


(* Line handler.
 * We take AssignExpresion line into account, store it to
 * lga datastructure for code generating
 * f: function to handle expression in general
 * a: line
 * return a var_lga
 *)
let handle_line fe ft a =
  match a with
  | ExpressionLine(line) ->
     begin match line  with
           | AssignExpression (x) -> ft fe x
           | _ -> Ignore
     end
  | _ -> Ignore

(* Body is a list of lines, which is the top level of LGA.
 * We only take AssignExpression line into account 
 * f: function to handle expression in general
 * a: body
 * return a list of var_lga
 *)
let handle_body fe ft a =
  List.map (handle_line fe ft) a

(* let handle_parenthetical f a =  *)
(*   match a with *)
(*   | Parenthetical(x) -> log("Parenthetical"); *)
(*                         handle_body f x *)

(* let handle_arguments f a =  *)
(*   log("Arguments"); *)
(*   handle_arg_list f a *)

(* let handle_invocation fe fv a = *)
(*   match a with *)
(*   | Invocation(x, y) -> log("Invocation"); *)
(*                         fv x; *)
(*                         handle_arguments fe y *)

(* let handle_assignable fe fv a = *)
(*   match a with *)
(*   | ArrayAssignable(x) -> log("ArrayAssignable"); *)
(*                           handle_array fe x *)
(*   | ObjAssignable(x) -> log("ObjAssignable"); *)
(*                         handle_obj fe x *)
(*   | IdentifierAssignable(x) ->  *)
(*      handle_identifier x; *)
(*      log("IdentifierAssignable") *)
(*   | ThisPropertyAssignable(x) ->  *)
(*      handle_this_property x; *)
(*      log("ThisPropertyAssignable") *)
(*   | ValueAccessorAssignable(x, y) ->  *)
(*      fv x; *)
(*      handle_accessor y; *)
(*      log("ValueAccessorAssignable") *)
(*   | InvocationAccessorAssignable(x, y) ->  *)
(*      handle_invocation fe fv x; *)
(*      handle_accessor y; *)
(*      log("InvocationAccessorAssignable") *)

(* let rec handle_value f a =  *)
(*   match a with *)
(*   | AssignableValue(x) ->  *)
(*      handle_assignable f (handle_value f) x; *)
(*      log("AssignableValue") *)
(*   | LiteralValue(x) ->  *)
(*      handle_literal x; *)
(*      log("LiteralValue") *)
(*   | ParentheticalValue(x) ->  *)
(*      handle_parenthetical f x; *)
(*      log("ParentheticalValue") *)

(* let handle_lop f a =  *)
(*   match a with *)
(*   | ValueLop(x) -> log("ValueLop"); *)
(*                    handle_value f x *)
(*   | InvocationLop(x) -> log("InvocationLop"); *)
(*                         handle_invocation f (handle_value f) x *)

(* let handle_operation f a =  *)
(*   match a with *)
(*   | Binop(x, y, z) -> log("Binop"); *)
(*                       handle_lop f x; *)
(*                       handle_op y; *)
(*                       f z *)
(*   | Neg(x) -> log("Neg"); *)
(*               f x *)

(* let handle_block f a =  *)
(*   log("Block"); *)
(*   handle_body f a *)

(* let handle_param_list a = *)
(*   List.map handle_identifier a *)

(* let handle_code f a = *)
(*   match a with *)
(*   | Code(x, y) ->  *)
(*      let param_list = handle_param_list x in *)
(*      FunctionBody(param_list, "FUNBODY") *)

(* let handle_assign f a = *)
(*   match a with *)
(*   | Assign(x, y) -> log("Assign"); *)
(*                     handle_assignable f (handle_value f) x; *)
(*                     f y *)

(* let rec handle_if_block f a = *)
(*   match a with *)
(*   | IfBlock(x, y) -> log("IfBlock"); *)
(*                   f x; *)
(*                   handle_block f y *)
(*   | IfBlockSeq(x, y, z) -> log("IfBlockSeq"); *)
(*                            handle_if_block f x; *)
(*                            f y; *)
(*                            handle_block f z *)

(* let handle_if f a =  *)
(*   match a with *)
(*   | IfElse(x, y) -> log("IfElse"); *)
(*                  handle_if_block f x; *)
(*                  handle_block f y *)
(*   | IfOnly(x) -> log("IfOnly"); *)
(*                  handle_if_block f x *)

(* let handle_while_source f a = *)
(*   match a with *)
(*   | WhileSource(x) -> log("WhileSource"); *)
(*                       f x *)

(* let handle_while f a =  *)
(*   match a with *)
(*   | While(x,y) -> log("While"); *)
(*                   handle_while_source f x; *)
(*                   handle_block f y *)

(* let handle_for_source f a =  *)
(*   match a with *)
(*   | ForSource(x) -> f x *)

(* let handle_for_var a =  *)
(*   match a with *)
(*   | ForVar(x) -> log("ForVar"); *)
(*                  handle_identifier x *)

(* let handle_for_start a = *)
(*   match a with *)
(*   | ForStart(x) -> log("ForStart"); *)
(*                  handle_for_var x *)

(* let handle_for_body f a =  *)
(*   match a with *)
(*   | ForBody(x, y) -> log("ForBody"); *)
(*                      handle_for_start x; *)
(*                      handle_for_source f y *)

(* let handle_for f a = *)
(*   match a with *)
(*   | For(x, y) -> log("For"); *)
(*                  handle_for_body f x; *)
(*                  handle_block f y *)


(* top level obj handler
 * return top_id_list
 *)
let handle_top_obj f obj =
    match obj with
    | Object(o) ->
       let construct aobj = 
       (* return a TopId(string, string) *)
         match aobj with
         | AssignObj(x, y) -> TopId(handle_obj_assignable x, "BODY")
       in
       TopIdList(List.map construct o)
    
(* top level handler
 * f: expression handler
 * a: input line (Which is a AssignExpresion) 
 * return a var_lga based on the type
 *)
let handle_top_level f a =
  match a with
  | Assign(left, right) ->
     let id = 
       begin match left with
         | IdentifierAssignable(y) ->
            handle_identifier y
         | _ -> raise(Failure("Only allow identifier as variable"))
       end
     in
     begin match right with
             | ValueExpression(o) ->
                begin match o with
                      | AssignableValue(a) ->
                         begin match a with
                               | ObjAssignable(obj) ->
                                  ObjVar_lga(TopObj(id, (handle_top_obj f obj)))
                         end
                end
       end
  | _ -> Ignore 

let rec handle_expr a =
  "Expression"
(*   match a with *)
(*   | ValueExpression(x) ->  *)
(*      handle_value handle_expr x *)
(*   | InvocationExpression(x) -> *)
(*      handle_invocation handle_expr (handle_value handle_expr) x *)
(*   | CodeExpression(x) -> *)
(*      handle_code handle_expr x *)
(*   | OperationExpression(x) ->  *)
(*      handle_operation handle_expr x *)
(*   | AssignExpression(x) ->  *)
(*      handle_assign handle_expr x *)
(*   | IfExpression(x) -> *)
(*      handle_if handle_expr x *)
(*   | WhileExpression(x) ->  *)
(*      handle_while handle_expr x *)
(*   | ForExpression(x) ->  *)
(*      handle_for handle_expr x *)

(* return a list of var_lga *)
let handle_root f body = 
  handle_body f handle_top_level body

let lga_of_file filename = 
  let root = ast_of_file Parser.root Scanner.token filename in
  handle_root handle_expr root
