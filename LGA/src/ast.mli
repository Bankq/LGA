type expr = 
    Assign of expr * expr
  | Id of string
  | Num of float
