(** Open modules *)
 open Ast
 open Parser

(** Returns the number of outdent(s) that occur at the beginning of one line according to the number of white spaces len and a stack. The stack holds the size of indents sequentially. the function is called when the new line has at least one outdent. The size of indent has to match some smaller level and the function returns a value equal or larger than 1, otherwise returns -1. *)
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

(** Returns all the test files' filenames in the directory dir. *)
let raw_testfile_list_of_dir = fun dir ->
  let infile_array = Sys.readdir dir in
  let raw_file_list = Array.to_list infile_array in
  let is_test_file file = 
    if (String.sub file 0 4) = "test" then true else false in
  List.filter is_test_file raw_file_list

(** Returns input files' path by concatenating directory name indir and filename. *)
let abs_input_testfile = fun indir filename->
  String.concat "" [indir;filename]

(** Returns expected output files' path by concatenating directory name outdir and filename. *)
let abs_output_testfile_of_input = fun outdir filename->
  String.concat "" [outdir;filename;".out"]

(** Print the PASS/FAIL result of a test file. Testfun is the function that returns testing results for input file infile and its expected output file outfile. *)
let get_test_result_string = fun testfun infile outfile ->
  let result = (testfun infile outfile) in
  if result then Printf.sprintf "Test %s PASS!" infile
  else Printf.sprintf "Test %s FAIL!" infile 

(** Print the PASS/FAIL results for all input test files in a directory indir with their expected output files in directory outdir. *)
let test_dir test_fun indir outdir = 
    let raw_list = raw_testfile_list_of_dir indir in
    let print = fun file ->
      let abs_in = abs_input_testfile indir file in
      let abs_out = abs_output_testfile_of_input outdir file in
      print_endline (get_test_result_string test_fun abs_in abs_out)
  in
  List.map print raw_list

(** Return a new list with int token OUTDENT_COUNT in the list expanded into cooresponding number of OUTDENT token(s), and TERMINATOR token(s) added to every line break. *)
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

(** Use tokenizer to process lexbuf and return the generated token list. *)
let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token = stopsign then (List.append list [token])
    else token :: (helper lexbuf list)
  in expand_token_list (helper lexbuf [])

(** Parse a file with myparser and tokenizer and return a list which represents the ast. *)
let ast_of_file myparser tokenizer filename =
  let lexbuf = Lexing.from_channel (open_in filename) in
  let token_list = ref (token_list_of_lexbuf lexbuf tokenizer Parser.EOF) in
  let tokenize lexbuf = 
    match !token_list with
    | [] -> Parser.TERMINATOR
    | h :: t -> token_list := t; h
  in
  myparser tokenize (Lexing.from_string "")

(** Match tokens to strings reflecting their names. *)
let string_of_token : Parser.token -> string = function
  | IDENTIFIER(x) ->
     Printf.sprintf "IDENTIFIER<%s>" x
  | NUM(x) ->
     Printf.sprintf "NUM<%s>" x
  | STATEMENT(x) ->
     Printf.sprintf "STATEMENT<%s>" x
  | BOOL(x) ->
     Printf.sprintf "BOOL<%s>" x
  | STRING(x) ->
     Printf.sprintf "STRING<%s>" x
  | ASSIGN ->
     "ASSIGN"
  | TERMINATOR ->
     "TERMINATOR"
  | RETURN ->
     "RETURN"
  | FUN ->
     "FUN"
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
