open Printf

open Ast
open Scanner
open Parser
open Utils

type senario = ID

let rs = ref []

let handle_op a = 
  rs := List.append !rs ["OP"]

let handle_literal a = 
  match a with
  | Literal(x) -> rs := List.append !rs ["Literal"];
                  rs := List.append !rs [x]

let handle_identifier a = 
  rs := List.append !rs ["Identifier"];
  handle_literal a
 

let handle_index_value a =
  rs := List.append !rs ["IndexValue"];
  handle_literal a

let handle_index a =
  match a with
  | Index(x) -> rs := List.append !rs ["Index"];
                handle_index_value x

let handle_accessor a = 
  match a with
  | DotAccessor(x) -> rs := List.append !rs ["DotAccessor"];
                      handle_identifier x
  | IndexAccessor(x) -> rs:= List.append !rs ["IndexAccessor"];
                        handle_index x

let handle_arg_list f a =
  rs := List.append !rs ["ArgList"];
  List.iter f a

let handle_array f a = 
  rs := List.append !rs ["Array"];
  handle_arg_list f a

let handle_this_property a =
  rs := List.append !rs ["ThisProperty"];
  handle_identifier a

let handle_obj_assignable a = 
  match a with
  | IdentifierObjAssignable(x) -> rs := List.append !rs ["IdentifierObjAssignable"];
                                  handle_identifier x
  | ThisPropertyObjAssignable(x) -> rs := List.append !rs ["ThisPropertyObjAssignable"];
                                    handle_this_property x

let handle_assign_obj f a =
  match a with
  | AssignObj(x, y) -> rs := List.append !rs ["AssignObj"]; 
                       handle_obj_assignable x;
                       f y

let handle_assign_list f a = 
  rs := List.append !rs ["AssignList"];
  List.iter (handle_assign_obj f) a

let handle_obj f a = 
  match a with
  | Object(x) -> rs := List.append !rs ["Object"];
                 handle_assign_list f x

let handle_return f a =
  match a with
  | Return(x) -> rs := List.append !rs ["Return"];
                 f x

let handle_statement f a =
  match a with
  | ReturnStatement(x) -> rs := List.append !rs ["ReturnStatement"];
                          handle_return f x
  | LiteralStatement(x) -> rs := List.append !rs ["LiteralStatement"];
                           handle_literal x

let handle_line f a =
  match a with
  | ExpressionLine(x) -> rs := List.append !rs ["ExpressionLine"];
                         f x
  | StatementLine(x) -> rs := List.append !rs ["StatementLine"];
                        handle_statement f x

let handle_body f a = 
  rs := List.append !rs ["Body"];
  List.iter (handle_line f) a

let handle_parenthetical f a = 
  match a with
  | Parenthetical(x) -> rs := List.append !rs ["Parenthetical"];
                        handle_body f x

let handle_arguments f a = 
  rs := List.append !rs ["Arguments"];
  handle_arg_list f a

let handle_invocation fe fv a =
  match a with
  | Invocation(x, y) -> rs := List.append !rs ["Invocation"];
                        fv x;
                        handle_arguments fe y

let handle_assignable fe fv a =
  match a with
  | ArrayAssignable(x) -> rs := List.append !rs ["ArrayAssignable"];
                          handle_array fe x
  | ObjAssignable(x) -> rs := List.append !rs ["ObjAssignable"];
                        handle_obj fe x
  | IdentifierAssignable(x) -> rs := List.append !rs ["IdentifierAssignable"];
                               handle_identifier x
  | ThisPropertyAssignable(x) -> rs := List.append !rs ["ThisPropertyAssignable"];
                                 handle_this_property x
  | ValueAccessorAssignable(x, y) -> rs := List.append !rs ["ValueAccessorAssignable"];
                                     fv x;
                                     handle_accessor y
  | InvocationAccessorAssignable(x, y) -> rs := List.append !rs ["InvocationAccessorAssignable"];
                                          handle_invocation fe fv x;
                                          handle_accessor y


let rec handle_value f a = 
  match a with
  | AssignableValue(x) -> rs := List.append !rs ["AssignableValue"];
                          handle_assignable f (handle_value f) x
  | LiteralValue(x) -> rs := List.append !rs ["LiteralValue"];
                       handle_literal x
  | ParentheticalValue(x) -> rs := List.append !rs ["ParentheticalValue"];
                             handle_parenthetical f x

let handle_lop f a = 
  match a with
  | ValueLop(x) -> rs := List.append !rs ["ValueLop"];
                   handle_value f x
  | InvocationLop(x) -> rs := List.append !rs ["InvocationLop"];
                        handle_invocation f (handle_value f) x

let handle_operation f a = 
  match a with
  | Binop(x, y, z) -> rs := List.append !rs ["Binop"];
                      handle_lop f x;
                      handle_op y;
                      f z
  | Neg(x) -> rs := List.append !rs ["Neg"];
              f x

let handle_block f a = 
  rs := List.append !rs ["Block"];
  handle_body f a

let handle_param_list a = 
  rs := List.append !rs ["ParamList"];
  List.iter handle_identifier a

let handle_code f a =
  match a with
  | Code(x, y) -> rs := List.append !rs ["Code"];
                  handle_param_list x;
                  handle_block f y

let handle_assign f a = 
  match a with
  | Assign(x, y) -> rs := List.append !rs ["Assign"];
                    handle_assignable f (handle_value f) x;
                    f y

let rec handle_if_block f a =
  match a with
  | IfBlock(x, y) ->  rs := List.append !rs ["IfBlock"];
                      f x;
                  handle_block f y
  | IfBlockSeq(x, y, z) -> rs := List.append !rs ["IfBlockSeq"];
                           handle_if_block f x;
                           f y;
                           handle_block f z

let handle_if f a = 
  match a with
  | IfElse(x, y) -> rs := List.append !rs ["IfElse"];
                    handle_if_block f x;
                 handle_block f y
  | IfOnly(x) -> rs := List.append !rs ["IfOnly"];
                 handle_if_block f x

let handle_while_source f a =
  match a with
  | WhileSource(x) -> rs := List.append !rs ["WhileSource"];
                      f x

let handle_while f a = 
  match a with
  | While(x,y) -> rs := List.append !rs ["While"];
                  handle_while_source f x;
                  handle_block f y

let handle_for_source f a = 
  match a with
  | ForSource(x) -> f x

let handle_for_var a = 
  match a with
  | ForVar(x) -> rs := List.append !rs ["ForVar"];
                 handle_identifier x

let handle_for_start a =
  match a with
  | ForStart(x) ->  rs := List.append !rs ["ForStart"];
                    handle_for_var x

let handle_for_body f a = 
  match a with
  | ForBody(x, y) -> rs := List.append !rs ["ForBody"];
                     handle_for_start x;
                     handle_for_source f y

let handle_for f a =
  match a with
  | For(x, y) -> rs := List.append !rs ["For"];
                 handle_for_body f x;
                 handle_block f y

let rec handle_expr a = 
  match a with
  | ValueExpression(x) -> rs := List.append !rs ["ValueExpression"];
                          handle_value handle_expr x
  | InvocationExpression(x) -> rs := List.append !rs ["InvocationExpression"];
                               handle_invocation handle_expr (handle_value handle_expr) x
  | CodeExpression(x) -> rs := List.append !rs ["CodeExpression"];
                         handle_code handle_expr x
  | OperationExpression(x) -> rs := List.append !rs ["OperationExpression"];
                              handle_operation handle_expr x
  | AssignExpression(x) -> rs := List.append !rs ["AssignExpression"];
                           handle_assign handle_expr x
  | IfExpression(x) -> rs := List.append !rs ["IfExpression"];
                       handle_if handle_expr x
  | WhileExpression(x) -> rs := List.append !rs ["WhileExpression"];
                          handle_while handle_expr x
  | ForExpression(x) -> rs := List.append !rs ["ForExpression"];
                        handle_for handle_expr x

let handle_root f body = 
  rs := [];
  handle_body f body

let get_ast_list filename =
  let root = ast_of_file Parser.root Scanner.token filename in
  let b = handle_root handle_expr root in
  !rs


                   

