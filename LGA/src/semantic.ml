open Printf
open Ast
open Scanner
open Parser
open Utils
open Lga

let makestr = fun a ->
  String.concat "" a

let op_to_string = fun a ->
  match a with
  | Plus -> "+"
  | Minus -> "-"
  | Times -> "*"
  | Divide -> "/"
  | Eq -> "=="
  | Neq -> "!="
  | Mod -> "%"
  | And -> "&&"
  | Or -> "||"
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | Not -> "!"


let handle_op a = 
  op_to_string a
	
let handle_literal a = 
  match a with
  | Literal(x) -> x

let handle_identifier a = 
  handle_literal a
	
let handle_index_value a =
  handle_literal a

let handle_index a =
  match a with
  | Index(x) -> "[" ^ handle_index_value x ^ "]"

let handle_accessor a = 
  match a with
  | DotAccessor(x) -> "." ^ (handle_identifier x)                     
  | IndexAccessor(x) -> handle_index x

let handle_arg_list f a =
  String.concat ", " (List.map f a)

let handle_array f a = 
  "[" ^ (handle_arg_list f a) ^ "]"

let handle_this_property a =
  "this." ^ (handle_identifier a)

let handle_obj_assignable a = 
  match a with
  | IdentifierObjAssignable(x) -> handle_identifier x
  | ThisPropertyObjAssignable(x) -> handle_this_property x

let handle_assign_obj f a =
  match a with
  | AssignObj(x, y) -> (handle_obj_assignable x) ^ " : " ^ (f y)

let handle_assign_list f a = 
  String.concat ",\n" (List.map (handle_assign_obj f) a)

let handle_obj f a = 
  match a with
  | Object(x) -> "{\n" ^ (handle_assign_list f x) ^ "\n}"
								
let handle_return f a =
  match a with
  | Return(x) -> "return " ^ (f x) 
								
let handle_statement f a =
  match a with
  | ReturnStatement(x) -> handle_return f x
  | LiteralStatement(x) -> handle_literal x
													
let handle_line f a =
  match a with
  | ExpressionLine(x) -> f x
  | StatementLine(x) -> handle_statement f x
							
let add_semicom = fun a -> a ^ ";"

let handle_body f a = 
	String.concat "\n" (List.map add_semicom (List.map (handle_line f) a))

let handle_parenthetical f a = 
  match a with
  | Parenthetical(x) -> "(" ^ (handle_body f x) ^ ")"                      

let handle_arguments f a = 
  "(" ^ (handle_arg_list f a) ^ ")"
	
let handle_invocation fe fv a =
  match a with
  | Invocation(x, y) -> (fv x) ^ (handle_arguments fe y)

let handle_assignable fe fv a =
  match a with
  | ArrayAssignable(x) -> handle_array fe x
  | ObjAssignable(x) -> handle_obj fe x
  | IdentifierAssignable(x) -> handle_identifier x
  | ThisPropertyAssignable(x) -> handle_this_property x
  | ValueAccessorAssignable(x, y) -> (fv x) ^ (handle_accessor y)   
  | InvocationAccessorAssignable(x, y) -> (handle_invocation fe fv x) ^ (handle_accessor y)

let rec handle_value f a = 
  match a with
  | AssignableValue(x) -> handle_assignable f (handle_value f) x
  | LiteralValue(x) -> handle_literal x
  | ParentheticalValue(x) -> handle_parenthetical f x

let handle_lop f a = 
  match a with
  | ValueLop(x) -> handle_value f x
  | InvocationLop(x) -> handle_invocation f (handle_value f) x

let handle_operation f a = 
  match a with
  | Binop(x, y, z) -> (handle_lop f x) ^ " " ^ (handle_op y) ^ " " ^ (f z)
  | Neg(x) -> "!" ^ (f x)
	
let handle_block f a = 
  handle_body f a

let handle_param_list a = 
  String.concat ", " (List.map handle_identifier a)

let handle_code f a =
  match a with
  | Code(x, y) -> let paraliststr = handle_param_list x in
                    let blockstr = handle_block f y in
                    "function (" ^ paraliststr ^ ")\n{\n" ^ blockstr ^ "\n}"


let handle_assign f a = 
  match a with
  | Assign(x, y) -> 
     (handle_assignable f (handle_value f) x) ^ " = " ^ (f y)

let rec handle_if_block f a =
  match a with
  | IfBlock(x, y) -> "if ( " ^ (f x) ^ " ) \n{\n" ^ (handle_block f y) ^ "\n}"
  | IfBlockSeq(x, y, z) -> 
		(handle_if_block f x) ^ "else if ( " ^ (f y) ^ " ) \n{\n" ^ (handle_block f z) ^ "\n}"
		
let handle_if f a = 
  match a with
  | IfElse(x, y) -> (handle_if_block f x) ^ " else {\n" ^ (handle_block f y) ^ "\n}"
  | IfOnly(x) -> handle_if_block f x


let handle_while_source f a =
  match a with
  | WhileSource(x) -> f x
   (*f x*) 

let handle_while f a = 
  match a with
  | While(x,y) -> let whilesourcestr = handle_while_source f x in
                      let blockstr = handle_block f y in
                        let herestr = makestr ["while ("; whilesourcestr; ")\n{\n ";blockstr;"\n}"] in
                          herestr
let handle_for_var a = 
  match a with
  | ForVar(x) -> let idstr = handle_identifier x in
            idstr

let handle_for_start a =
  match a with
  | ForStart(x) ->  let varstr = handle_for_var x in
              varstr

let handle_for_source f a = 
  match a with
  | ForSource(x) -> f x


let handle_for_body f a = 
  match a with
  | ForBody(x, y) -> let forstartstr = handle_for_start x in
                      let forsourcestr = handle_for_source f y in
                        let herers = makestr ["("; forstartstr;" in ";forsourcestr;")"] in
                          herers

let handle_for f a =
  match a with
  | For(x, y) -> let forbodystr = handle_for_body f x in
                  let blockstr = handle_block f y in
                    let herestr = makestr ["for ";forbodystr;"\n{\n "; blockstr; "\n }"] in
                      herestr

                    
let rec handle_expr a = 
  match a with
  | ValueExpression(x) -> handle_value handle_expr x
  | InvocationExpression(x) -> handle_invocation handle_expr (handle_value handle_expr) x
  | CodeExpression(x) -> handle_code handle_expr x
  | OperationExpression(x) -> handle_operation handle_expr x
  | AssignExpression(x) -> (handle_assign handle_expr x)
  | IfExpression(x) -> handle_if handle_expr x
  | WhileExpression(x) -> handle_while handle_expr x
  | ForExpression(x) -> handle_for handle_expr x

let handle_root f body = 
  handle_body f body

let rec explode = function
    "" -> []
  | s  -> (String.get s 0) ::
          explode (String.sub s 1 ((String.length s) - 1))

let rec implode = function
    []       -> ""
  | charlist -> (String.make 1 (List.hd charlist)) ^
                                  (implode (List.tl charlist));;

let rec remove x =
  match x with
  | a :: (b :: c)  ->
    if a == '}' && b == ';' then a :: (remove c)
        else a :: (remove (List.tl x))
  | _ -> x
 
(* Line handler.
 * We take AssignExpresion line into account, store it to
 * lga datastructure for code generating
 * f: function to handle expression in general
 * a: line
 * return a var_lga
 *)
let handle_top_line fe ft a =
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
let handle_top_body fe ft a =
  List.map (handle_top_line fe ft) a

(* top level obj handler
 * return top_id_list
 *)
let handle_top_obj f obj =
    match obj with
    | Object(o) ->
       let construct aobj = 
       (* return a TopId(string, string) *)
         match aobj with
         | AssignObj(x, y) -> TopId(handle_obj_assignable x, (f y))
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
             | ValueExpression(AssignableValue(ObjAssignable(obj))) ->
                ObjVar_lga(TopObj(id, (handle_top_obj f obj)))
             | _ -> IdVar_lga(TopId(id, (f right)))
     end



(* return a list of var_lga *)
let handle_top_root f body = 
  handle_top_body f handle_top_level body

let lga_of_file filename = 
  let root = ast_of_file Parser.root Scanner.token filename in
  handle_top_root handle_expr root

let get_code_str filename =
  let root = ast_of_file Parser.root Scanner.token filename in
  let b = handle_root handle_expr root in
    implode (remove (explode b))
