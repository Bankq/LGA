(* root: list of CodeBlock *)
type 'a dummy = 'a
type op = Plus | Minus | Times | Divide | Eq | Neq | Mod | And | Or | Less | Leq | Greater | Geq | Not

type literal = Literal of string
type identifier = literal


type indexValue = literal
type index = Index of indexValue

type accessor =
    DotAccessor of identifier
  | IndexAccessor of index

type 'a argList = 'a list
type 'a array = 'a argList


type thisProperty = identifier

type objAssignable =
    IdentifierObjAssignable of identifier
  | ThisPropertyObjAssignable of thisProperty

type 'a assignObj = AssignObj of objAssignable * 'a
type 'a assignList = 'a assignObj list
type 'a obj = Object of 'a assignList

type 'a return = Return of 'a

type 'a statement =
    ReturnStatement of 'a return
  | LiteralStatement of literal

type 'a line =
    ExpressionLine of 'a
  | StatementLine of 'a statement

type 'a body = ('a line) list
type 'a parenthetical = Parenthetical of 'a body

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
  | InvocationValue of ('a, 'a value) invocation * accessor
  | LiteralValue of literal
  | ParentheticalValue of 'a parenthetical



type 'a lop =
    ValueLop of 'a value
  | InvocationLop of ('a, 'a value) invocation

type 'a operation =
    Binop of 'a lop * op * 'a
  | Neg of 'a




type 'a block = 'a body
    
type paramList = identifier list
type 'a code = Code of paramList * 'a block

type 'a assign = Assign of ('a, 'a value) assignable * 'a



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

type expression =
    ValueExpression of expression value
  | InvocationExpression of (expression, expression value) invocation
  | CodeExpression of expression code
  | OperationExpression of expression operation
  | AssignExpression of expression assign
  | IfExpression of expression iftype
  | WhileExpression of expression whiletype
  | ForExpression of expression fortype


type root = expression body 
    
