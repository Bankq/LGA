open Lga
open Ast
open Parser
open Semantic
open List
open String

let lga_translate_type a = 
  match a with
  | "Rectangle" -> "two.makeRectangle"
  | "Circle" -> "two.makeCircle"
  | _ as field-> "two.make"^field
  
let lga_get_by_field field a = 
  match a with
  | TopId(k, v) -> if k = field then true else false

let lga_find_field field l =
  try 
    let target = find (lga_get_by_field field) l in
    match target with
    | TopId(x, y) -> 
       try
       String.sub y 1 ((String.length y) - 2)
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
                    | _ as field -> (id^"."^field^" = "^value^";\n") :: lga_obj_type id t
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


let gen_code a =
  match a with
  | ObjVar_lga(x) -> lga_top_obj x
  | IdVar_lga(x) -> lga_top_id x
  | _ -> ""

let _ = 
  let filename = Sys.argv.(1) in
  let lga = lga_of_file filename in
  List.map print_endline (List.map gen_code lga)
