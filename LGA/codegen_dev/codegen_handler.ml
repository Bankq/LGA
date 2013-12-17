open Printf

open Ast
open Scanner
open Parser
open Utils

type senario = ID

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
  | Object(x) -> "{" ^ (handle_assign_list f x) ^ "}"
								
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
												
let handle_body f a = 
	String.concat ";\n" (List.map (handle_line f) a)

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
  | Code(x, y) -> log("Code");
                  handle_param_list x;
                  handle_block f y

let handle_assign f a = 
  match a with
  | Assign(x, y) -> (handle_assignable f (handle_value f) x) ^ " = " ^ (f y)

let rec handle_if_block f a =
  match a with
  | IfBlock(x, y) -> "if ( " ^ (f x) ^ " ) \n{" ^ (handle_block f y) ^ "\n}"
  | IfBlockSeq(x, y, z) -> 
		(handle_if_block f x) ^ "else if ( " ^ (f y) ^ " ) \n{" ^ (handle_block f z) ^ "\n}"
		
let handle_if f a = 
  match a with
  | IfElse(x, y) -> (handle_if_block f x) ^ " else \n{" ^ (handle_block f y) "}"
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
  (*| ForSource(x) -> f x*)
  | ForSource(x) -> "ForSource"

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
  | AssignExpression(x) -> handle_assign handle_expr x
  | IfExpression(x) -> handle_if handle_expr x
  | WhileExpression(x) -> handle_while handle_expr x
  | ForExpression(x) -> handle_for handle_expr x

let handle_root f body = 
  handle_body f body

  let get_code_str filename =
  let root = ast_of_file Parser.root Scanner.token filename in
  let b = handle_root handle_expr root in
    b