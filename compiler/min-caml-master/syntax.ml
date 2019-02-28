type t = (*  MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
  | Unit of int * int * int
  | Bool of bool * int * int * int
  | Int of int * int * int * int
  | Float of float * int * int * int
  | Not of t * int * int * int
  | Neg of t * int * int * int
  | Add of t * t * int * int * int
  | Sub of t * t * int * int * int
  | Mul of t * t * int * int * int
  | Div of t * t * int * int * int
  | FNeg of t * int * int * int
  | FAdd of t * t * int * int * int
  | FSub of t * t * int * int * int
  | FMul of t * t * int * int * int
  | FDiv of t * t * int * int * int
  | Eq of t * t * int * int * int
  | LE of t * t * int * int * int
  | If of t * t * t * int * int * int
  | Let of (Id.t * Type.t) * t * t * int * int * int
  | Var of Id.t * int * int * int
  | LetRec of fundef * t * int * int * int
  | App of t * t list * int * int * int
  | Tuple of t list * int * int * int
  | LetTuple of (Id.t * Type.t) list * t * t * int * int * int
  | Array of t * t * int * int * int
  | Get of t * t * int * int * int
  | Put of t * t * t * int * int * int
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }


let get_pos syntax_t =
  match syntax_t with
   | Unit (line, start, s_end)
   | Bool (_, line, start, s_end)
   | Int (_, line, start, s_end)
   | Float (_, line, start, s_end)
   | Not (_, line, start, s_end)
   | Neg (_, line, start, s_end)
   | Add (_, _, line, start, s_end)
   | Sub (_, _, line, start, s_end)
   | Mul (_, _, line, start, s_end)
   | Div (_, _, line, start, s_end)
   | FNeg (_, line, start, s_end)
   | FAdd (_, _, line, start, s_end)
   | FSub (_, _, line, start, s_end)
   | FMul (_, _, line, start, s_end)
   | FDiv (_, _, line, start, s_end)
   | Eq (_, _, line, start, s_end)
   | LE (_, _, line, start, s_end)
   | If (_, _, _, line, start, s_end)
   | Let (_, _, _, line, start, s_end)
   | Var (_, line, start, s_end)
   | LetRec (_, _, line, start, s_end)
   | App (_, _, line, start, s_end)
   | Tuple (_, line, start, s_end)
   | LetTuple (_, _, _, line, start, s_end)
   | Array (_, _, line, start, s_end)
   | Get (_, _, line, start, s_end)
   | Put (_, _, _, line, start, s_end) -> (line, start, s_end)



(*
type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | FNeg of t
  | FAdd of t * t
  | FSub of t * t
  | FMul of t * t
  | FDiv of t * t
  | Eq of t * t
  | LE of t * t
  | If of t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of t * t list
  | Tuple of t list
  | LetTuple of (Id.t * Type.t) list * t * t
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }
*)
