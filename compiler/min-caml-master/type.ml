type t = (* MinCamlの型を表現するデータ型. (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* 新しい型変数を作る *)

(*
type t2 = (* MinCamlの型と位置を表現するデータ型. (int * int * int)は(line, start, end)の位置情報(caml2html: type_t) *)
  | Unit of (int * int * int)
  | Bool of (int * int * int)
  | Int of (int * int * int)
  | Float of (int * int * int)
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref



let t2_to_t = function
  | Unit _ -> (Unit :t)
  | Bool _ -> Bool
  | Int _ -> Int
  | Float _ -> Float
  | Fun (t_list, t) -> Fun (t_list, t)
  | Tuple t_list -> Tuple t_list
  | Array t -> Array t
  | Var t -> Var t
*)
