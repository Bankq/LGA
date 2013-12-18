type shape = Rect | Circle

(* id = id *)
type top_id = TopId of string * string 

type top_id_list = TopIdList of top_id list
(* id = {
         [ string : string,
           string : string,
                  .
                  .
                  .
         ]
        }
 *)
type top_obj = TopObj of string * top_id_list

(* id = function (...) {...} *)
type var_lga = 
    ObjVar_lga of top_obj
  | IdVar_lga of top_id
  | Ignore

type lga = var_lga list
