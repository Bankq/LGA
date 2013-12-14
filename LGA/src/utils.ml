open Ast
open Parser

let outdent_count = fun len stack -> 
  let rec helper inc = 
    if (Stack.top stack) > len then
      begin 
        Stack.pop stack;
        helper (inc + 1)
      end
    else if (Stack.top stack) < len then -1
    else inc
  in helper 0

let raw_testfile_list_of_dir = fun dir ->
  let infile_array = Sys.readdir dir in
  let raw_file_list = Array.to_list infile_array in
  let is_test_file file = 
    if (String.sub file 0 4) = "test" then true else false in
  List.filter is_test_file raw_file_list

let abs_input_testfile = fun indir filename->
  String.concat "" [indir;filename]

let abs_output_testfile_of_input = fun outdir filename->
  String.concat "" [outdir;filename;".out"]

let get_test_result_string = fun testfun infile outfile ->
  let result = (testfun infile outfile) in
  if result then Printf.sprintf "Test %s PASS!" infile
  else Printf.sprintf "Test %s FAIL!" infile 

let test_dir test_fun indir outdir = 
    let raw_list = raw_testfile_list_of_dir indir in
    let print = fun file ->
      let abs_in = abs_input_testfile indir file in
      let abs_out = abs_output_testfile_of_input outdir file in
      print_endline (get_test_result_string test_fun abs_in abs_out)
  in
  List.map print raw_list

let rec expand_token_list = fun list ->
  let rec expand_token = fun token ->
    match token with
    | INDENT -> TERMINATOR :: [token]
    | OUTDENT_COUNT(x) ->
       let rec populate token =
         match token with
         | OUTDENT_COUNT(x) ->
            if x = 1 then [OUTDENT]
            else OUTDENT :: (populate (OUTDENT_COUNT(x-1)))
         | _ -> [token] in
       TERMINATOR :: (populate token)
    | _ -> [token] in
  List.flatten (List.map expand_token list)

let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token = stopsign then list
    else token :: (helper lexbuf list)
  in expand_token_list (helper lexbuf [])

let ast_of_file myparser tokenizer filename =
  let lexbuf = Lexing.from_channel (open_in filename) in
  let token_list = ref (token_list_of_lexbuf lexbuf tokenizer Parser.EOF) in
  let tokenize lexbuf = 
    match !token_list with
    | [] -> Parser.TERMINATOR
    | h :: t -> token_list := t; h
  in
  myparser tokenize (Lexing.from_string "")

let string_of_token : Parser.token -> string = function
  | IDENTIFIER(x) ->
     Printf.sprintf "IDENTIFIER<%s>" x
  | NUM(x) ->
     Printf.sprintf "NUM<%s>" x
  | STATEMENT(x) ->
     Printf.sprintf "STATEMENT<%s>" x
  | BOOL(x) ->
     Printf.sprintf "BOOL<%s>" x
  | ASSIGN ->
     "ASSIGN"
  | TERMINATOR ->
     "TERMINATOR"
  | RETURN ->
     "RETURN"
  | ARROW ->
     "ARROW"
  | LBK ->
     "LBK"
  | RBK ->
     "RBK"
  | LPAREN ->
     "LPAREN"
  | RPAREN ->
     "RPAREN"
  | LBRACE ->
     "LBRACE"
  | RBRACE ->
     "RBRACE"
  | PLUS ->
     "PLUS"
  | MINUS ->
     "MINUS"
  | TIMES ->
     "TIMES"
  | DIVIDE ->
     "DIVIDE"
  | EQ ->
     "EQ"
  | NEQ ->
     "NEQ"
  | MOD ->
     "MOD"
  | AND ->
     "AND"
  | OR ->
     "OR"
  | LT ->
     "LT"
  | LEQ ->
     "LEQ"
  | GT ->
     "GT"
  | GEQ ->
     "GEQ"
  | NOT ->
     "NOT"
  | COLON ->
     "COLON"
  | COMMA ->
     "COMMA"
  | DOT ->
     "DOT"
  | NULL(x) ->
     "NULL"
  | THIS ->
     "THIS"
  | IF ->
     "IF"
  | ELSE ->
     "ELSE"
  | WHILE ->
     "WHILE"
  | FOR ->
     "FOR"
  | FORIN ->
     "FORIN"
  | INDENT ->
     "INDENT"
  | OUTDENT_COUNT(x) ->
     Printf.sprintf "OUTDENT<%d>" x
  | OUTDENT ->
     "OUTDENT"
  | EOF ->
     "EOF"
  | _ ->
     "UNKNOWN"
