
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

type fun_body = FunctionBody of string list * string

(* id = function (...) {...} *)
type top_fun = TopFun of string * fun_body

type var_lga = 
    ObjVar_lga of top_obj
  | FunVar_lga of top_fun
  | IdVar_lga of top_id
  | Ignore

type lga = var_lga list
