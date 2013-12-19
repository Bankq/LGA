open Lga
open Ast
open Parser
open Semantic
open List
open String

type output = Js | Lga

let lga_translate_type a = 
  match a with
  | "Rectangle" -> "two.makeRectangle"
  | "Circle" -> "two.makeCircle"
  | _ as field-> "two.make"^ (String.sub field 0 ((String.length field) - 1))
  
let lga_get_by_field field a = 
  match a with
  | TopId(k, v) -> if k = field then true else false

let lga_find_field field l =
  try 
    let target = find (lga_get_by_field field) l in
    match target with
    | TopId(x, y) -> 
       try
       String.sub y 1 ((String.length y) - 3)
       with
       | Invalid_argument(x) -> "0, 0"
  with
  | Not_found -> "0, 0"
       
let rec lga_obj_type id a = 
  match a with
  | h :: t ->
     begin match h with
           | TopId(key, value) ->
              begin match key with
                    | "type" -> 
                       let pos = lga_find_field "pos" t in
                       let size = lga_find_field "size"  t in
                       let objtype = lga_translate_type value in
                       (id^" = "^objtype^"("^pos^", "^size^");\n") 
                       ::(lga_obj_type id t)
                    | "pos" -> lga_obj_type id t
                    | "size" -> lga_obj_type id t
                    | _ as field -> (id^"."^field^" = "^value^"\n") :: lga_obj_type id t
               end
      end
   | _ -> []


let lga_top_id a = 
  match a with
  | TopId(key, value) ->
     "var "^key^" = "^value

(* return [ "var ID;" "ID.key = value;" "var ID_KEY = function ..." ...]*)
let lga_top_obj a =
  match a with
  | TopObj(id, alist) -> 
     concat ""
            (append ["var ";id;";\n"] 
                    begin match alist with
                          | TopIdList(list) -> (lga_obj_type id list)
                    end)


let lga_generate_code a =
  match a with
  | ObjVar_lga(x) -> lga_top_obj x
  | IdVar_lga(x) -> lga_top_id x
  | _ -> ""

let gen_code filename t = 
  match t with
  | Lga -> 
     let lga = lga_of_file filename in
     String.concat "\n" (List.map lga_generate_code lga)
  | Js ->
     js_of_file filename

let temp_head = 
  "var elem = document.getElementById('lga-div');
   var params = { width: 1080, height: 1024 };
   var two = new Two(params).appendTo(elem);
   var run = function(f) {}"

let temp_tail = 
  "two.bind('update', run).play();"

let get_mode m = 
  if m then Lga else Js

let mode = ref true
let in_file = ref "test.lga"
let out_file = ref "lga.js"
let get_in_name x = in_file := x

let spec = [
  ("-js", Arg.Clear mode, "Enable Javascript mode");
  ("-o", Arg.Set_string out_file, "Output file");
]
let usage = "lgac: [-js] [-o outputfile] inputfile"

let gen_output file t channel = 
  match t with
  | Lga ->
     Printf.fprintf channel "%s\n%s\n%s\n" temp_head (gen_code file t) temp_tail
  | _ -> Printf.fprintf channel "%s\n" (gen_code file t)

let _ = 
  Arg.parse spec get_in_name usage;
  let oc = open_out !out_file in
  gen_output !in_file (get_mode !mode) oc;
  close_out oc
  
