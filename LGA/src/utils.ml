(** The Util module is a grouping of commonly-needed functions. *)

open Ast
open Parser
open Printf
open Lexing
let log x = print_endline x

(** Returns the number of outdent(s) that occur at the
    beginning of one line according to the number of
    white spaces and a stack. The stack sequentially holds
    the size of pre-occurred indents that haven't been
    matched yet by outdents. the function is called when
    the new line has at least one outdent. The size of 
    indent has to match some smaller level and the function 
    returns a value equal or larger than 1, otherwise 
    returns -1. *)
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

(** Returns all the test files' filenames in a directory. *)
let raw_testfile_list_of_dir = fun dir ->
  let infile_array = Sys.readdir dir in
  let raw_file_list = Array.to_list infile_array in
  let is_test_file file = 
    if (String.sub file 0 4) = "test" then true else false in
  List.filter is_test_file raw_file_list

(** Returns a input file's path by concatenating directory 
    and filename. *)
let abs_input_testfile = fun indir filename->
  String.concat "" [indir;filename]

(** Returns a expected output file's path by concatenating 
    directory and filename. *)
let abs_output_testfile_of_input = fun outdir filename->
  String.concat "" [outdir;filename;".out"]

(** Return the PASS/FAIL result string of a test file with a
    test function. A test function is the function that returns
    testing results for a input file and its expected output 
    file. *)
let get_test_result_string = fun testfun infile outfile ->
  let result = (testfun infile outfile) in
  if result then Printf.sprintf "Test %s PASS!" infile
  else Printf.sprintf "Test %s FAIL!" infile 

(** Print the results of testing all test files in indir, 
    their expected output files are in outdir. *)
let test_dir test_fun indir outdir = 
    let raw_list = raw_testfile_list_of_dir indir in
    let print = fun file ->
      let abs_in = abs_input_testfile indir file in
      let abs_out = abs_output_testfile_of_input outdir file in
      print_endline (get_test_result_string test_fun abs_in abs_out)
  in
  List.map print raw_list

(** Return a new list with int token OUTDENT_COUNT in the list
    expanded into cooresponding number of OUTDENT token(s), and 
    TERMINATOR token(s) added after each INDENT and set of OUTDENT(s). *)
let rec expand_token_list = fun list ->
  let rec expand_token = fun token ->
    match token with
    | INDENT -> [token]
    | OUTDENT_COUNT(x) ->
       let rec populate token =
         match token with
         | OUTDENT_COUNT(x) ->
            if x = 1 then [OUTDENT]
            else OUTDENT :: (populate (OUTDENT_COUNT(x-1)))
         | _ -> [token] in
       List.append (populate token) [TERMINATOR]
    | _ -> [token] in
  List.flatten (List.map expand_token list)

(** Use tokenizer to process lexbuf and return the generated
    token list. The end of lexbuf is detected *)
let token_list_of_lexbuf lexbuf tokenizer stopsign =
  let rec helper lexbuf list = 
    let token = tokenizer lexbuf in 
    if token = stopsign then (List.append list [token])
    else token :: (helper lexbuf list)
  in expand_token_list (helper lexbuf [])

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

(** Parse a file with myparser and tokenizer and return a list which represents the ast. *)
let ast_of_file myparser tokenizer filename =
  let lexbuf = Lexing.from_channel (open_in filename) in
  let token_list = ref (token_list_of_lexbuf lexbuf tokenizer Parser.EOF) in
  let tokenize lexbuf = 
    match !token_list with
    | [] -> Parser.EOF
    | h :: t -> token_list := t; h
  in
  myparser tokenize (Lexing.from_string "")

(** Increment line number information of lexbuf. *)
let incr_linenum lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <- { pos with
    pos_lnum = pos.pos_lnum + 1;
    pos_bol = pos.pos_cnum;
  }
