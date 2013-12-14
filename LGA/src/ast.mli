(* root: list of CodeBlock *)
type 'a dummy = 'a
type op = Plus | Minus | Times | Divide | Eq | Neq | Mod | And | Or | Less | Leq | Greater | Geq | Not

type literal = Literal of string
type accessor =
    DotAccessor of literal
  | IndexAccessor of literal

type 'a argList = 'a list
type 'a array = 'a argList

type identifier = literal
type thisProperty = identifier

type objAssignable =
    IdentifierObjAssignable of identifier
  | ThisPropertyObjAssignable of thisProperty

type 'a assignObj = AssignObj of objAssignable * 'a
type 'a assignList = 'a assignObj list
type 'a obj = Object of 'a assignList

type 'a parenthetical = Parenthetical of 'a

type 'a arguments = 'a argList
type ('expr, 'value) invocation = Invocation of 'value * 'expr arguments

type ('expr, 'value) assignable =
    ArrayAssignable of 'expr array
  | ObjAssignable of 'expr obj
  | IdentifierAssignable of identifier
  | ThisPropertyAssignable of thisProperty
  | ValueAccessorAssignable of 'value * accessor
  | InvocationAccessorAssignable of ('expr, 'value) invocation * accessor

type 'a value =
    AssignableValue of ('a, 'a value) assignable
  | InvocationAccessorAssignable of ('a, 'a value) invocation * accessor
  | LiteralValue of literal
  | ParentheticalValue of 'a parenthetical



type 'a lop =
    ValueLop of 'a value
  | InvocationLop of ('a, 'a value) invocation

type 'a operation =
    Binop of 'a lop * op * 'a
  | Neg of 'a

type 'a return = Return of 'a

type 'a statement =
    ReturnStatement of 'a return
  | LiteralStatement of literal

type 'a line =
    ExpressionLine of 'a
  | StatementLine of 'a statement

type 'a body = 'a line list
type 'a block = 'a body
    
type paramList = identifier list
type 'a code = Code of paramList * 'a block

type 'a assign = Assign of ('a, 'a value) assignable * 'a

type indexValue = literal
type index = Index of indexValue

type 'a ifBlock = 
    IfBlock of 'a * 'a block
  | IfBlockSeq of 'a ifBlock * 'a * 'a block

type 'a iftype = 
    IfElse of 'a ifBlock * 'a block
  | IfOnly of 'a ifBlock

type 'a whileSource = WhileSource of 'a
type 'a whiletype = While of 'a whileSource * 'a block

type 'a forSource = ForSource of 'a
type forVar = ForVar of identifier
type forStart = ForStart of forVar
type 'a forBody = ForBody of forStart * 'a forSource
type 'a fortype  = For of 'a forBody * 'a block

type 'a expression =
    ValueExpression of 'a value
  | InvocationExpression of ('a, 'a value) invocation
  | CodeExpression of 'a code
  | OperationExpression of 'a operation
  | AssignExpression of 'a assign
  | IfExpression of 'a iftype
  | WhileExpression of 'a whiletype
  | ForExpression of 'a fortype


type 'a root = 'a body 
    
