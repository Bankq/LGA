open Printf

open Ast
open Scanner
open Parser
open Utils

type senario = ID

let handle_op a = 
  log("OP")

let handle_literal a = 
  match a with
  | Literal(x) -> log("Literal");
                  log(x)

let handle_identifier a = 
  log("Identifier");
  handle_literal a

let handle_index_value a =
  log("IndexValue");
  handle_literal a

let handle_index a =
  match a with
  | Index(x) -> log("Index");
                handle_index_value x

let handle_accessor a = 
  match a with
  | DotAccessor(x) -> log("DotAccessor");
                      handle_identifier x
  | IndexAccessor(x) -> log("IndexAccessor");
                        handle_index x

let handle_arg_list f a =
  log("ArgList");
  List.iter f a

let handle_array f a = 
  log("Array");
  handle_arg_list f a

let handle_this_property a =
  log("ThisProperty");
  handle_identifier a

let handle_obj_assignable a = 
  match a with
  | IdentifierObjAssignable(x) -> log("IdentifierObjAssignable");
                                  handle_identifier x
  | ThisPropertyObjAssignable(x) -> log("ThisPropertyObjAssignable");
                                    handle_this_property x

let handle_assign_obj f a =
  match a with
  | AssignObj(x, y) -> log("AssignObj");
                       handle_obj_assignable x;
                       f y

let handle_assign_list f a = 
  log("AssignList");
  List.iter (handle_assign_obj f) a

let handle_obj f a = 
  match a with
  | Object(x) -> log("Object");
                 handle_assign_list f x

let handle_return f a =
  match a with
  | Return(x) -> log("Return");
                 f x

let handle_statement f a =
  match a with
  | ReturnStatement(x) -> log("ReturnStatement");
                          handle_return f x
  | LiteralStatement(x) -> log("LiteralStatement");
                           handle_literal x

let handle_line f a =
  match a with
  | ExpressionLine(x) -> log("ExpressionLine");
                         f x
  | StatementLine(x) -> log("StatementLine");
                        handle_statement f x

let handle_body f a = 
  log("Body");
  List.iter (handle_line f) a

let handle_parenthetical f a = 
  match a with
  | Parenthetical(x) -> log("Parenthetical");
                        handle_body f x

let handle_arguments f a = 
  log("Arguments");
  handle_arg_list f a

let handle_invocation fe fv a =
  match a with
  | Invocation(x, y) -> log("Invocation");
                        fv x;
                        handle_arguments fe y

let handle_assignable fe fv a =
  match a with
  | ArrayAssignable(x) -> log("ArrayAssignable");
                          handle_array fe x
  | ObjAssignable(x) -> log("ObjAssignable");
                        handle_obj fe x
  | IdentifierAssignable(x) -> log("IdentifierAssignable");
                               handle_identifier x
  | ThisPropertyAssignable(x) -> log("ThisPropertyAssignable");
                                 handle_this_property x
  | ValueAccessorAssignable(x, y) -> log("ValueAccessorAssignable");
                                     fv x;
                                     handle_accessor y
  | InvocationAccessorAssignable(x, y) -> log("InvocationAccessorAssignable");
                                          handle_invocation fe fv x;
                                          handle_accessor y

let rec handle_value f a = 
  match a with
  | AssignableValue(x) -> log("AssignableValue");
                          handle_assignable f (handle_value f) x
  | LiteralValue(x) -> log("LiteralValue");
                       handle_literal x
  | ParentheticalValue(x) -> log("ParentheticalValue");
                             handle_parenthetical f x

let handle_lop f a = 
  match a with
  | ValueLop(x) -> log("ValueLop");
                   handle_value f x
  | InvocationLop(x) -> log("InvocationLop");
                        handle_invocation f (handle_value f) x

let handle_operation f a = 
  match a with
  | Binop(x, y, z) -> log("Binop");
                      handle_lop f x;
                      handle_op y;
                      f z
  | Neg(x) -> log("Neg");
              f x

let handle_block f a = 
  log("Block");
  handle_body f a

let handle_param_list a = 
  log("ParamList");
  List.iter handle_identifier a

let handle_code f a =
  match a with
  | Code(x, y) -> log("Code");
                  handle_param_list x;
                  handle_block f y

let handle_assign f a = 
  match a with
  | Assign(x, y) -> log("Assign");
                    handle_assignable f (handle_value f) x;
                    f y

let rec handle_if_block f a =
  match a with
  | IfBlock(x, y) -> log("IfBlock");
                  f x;
                  handle_block f y
  | IfBlockSeq(x, y, z) -> log("IfBlockSeq");
                           handle_if_block f x;
                           f y;
                           handle_block f z

let handle_if f a = 
  match a with
  | IfElse(x, y) -> log("IfElse");
                 handle_if_block f x;
                 handle_block f y
  | IfOnly(x) -> log("IfOnly");
                 handle_if_block f x

let handle_while_source f a =
  match a with
  | WhileSource(x) -> log("WhileSource");
                      f x

let handle_while f a = 
  match a with
  | While(x,y) -> log("While");
                  handle_while_source f x;
                  handle_block f y

let handle_for_source f a = 
  match a with
  | ForSource(x) -> f x

let handle_for_var a = 
  match a with
  | ForVar(x) -> log("ForVar");
                 handle_identifier x

let handle_for_start a =
  match a with
  | ForStart(x) -> log("ForStart");
                 handle_for_var x

let handle_for_body f a = 
  match a with
  | ForBody(x, y) -> log("ForBody");
                     handle_for_start x;
                     handle_for_source f y

let handle_for f a =
  match a with
  | For(x, y) -> log("For");
                 handle_for_body f x;
                 handle_block f y

let rec handle_expr a = 
  match a with
  | ValueExpression(x) -> log("ValueExpression");
                          handle_value handle_expr x
  | InvocationExpression(x) -> log("InvocationExpression");
                               handle_invocation handle_expr (handle_value handle_expr) x
  | CodeExpression(x) -> log("CodeExpression");
                         handle_code handle_expr x
  | OperationExpression(x) -> log("OperationExpression");
                              handle_operation handle_expr x
  | AssignExpression(x) -> log("AssignExpression");
                           handle_assign handle_expr x
  | IfExpression(x) -> log("IfExpression");
                       handle_if handle_expr x
  | WhileExpression(x) -> log("WhileExpression");
                          handle_while handle_expr x
  | ForExpression(x) -> log("ForExpression");
                        handle_for handle_expr x

let handle_root f body = 
  handle_body f body

let _ = 
  let filename = Sys.argv.(1) in
  let root = ast_of_file Parser.root Scanner.token filename in
  handle_root handle_expr root
                   

