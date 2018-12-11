type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t2) *)
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
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

let rec remove_pos syntax_t =
  match syntax_t with
   | Syntax.Unit (_, _, _) -> Unit
   | Syntax.Bool (b, _, _, _) -> Bool(b)
   | Syntax.Int (i, _, _, _) -> Int(i)
   | Syntax.Float (f, _, _, _) -> Float(f)
   | Syntax.Not (t, _, _, _) -> Not(remove_pos t)
   | Syntax.Neg (t, _, _, _) -> Neg(remove_pos t)
   | Syntax.Add (t1, t2, _, _, _) -> Add(remove_pos t1, remove_pos t2)
   | Syntax.Sub (t1, t2, _, _, _) -> Sub(remove_pos t1, remove_pos t2)
   | Syntax.Mul (t1, t2, _, _, _) -> Mul(remove_pos t1, remove_pos t2)
   | Syntax.Div (t1, t2, _, _, _) -> Div(remove_pos t1, remove_pos t2)
   | Syntax.FNeg (t, _, _, _) -> FNeg(remove_pos t)
   | Syntax.FAdd (t1, t2, _, _, _) -> FAdd (remove_pos t1, remove_pos t2)
   | Syntax.FSub (t1, t2, _, _, _) -> FSub (remove_pos t1, remove_pos t2)
   | Syntax.FMul (t1, t2, _, _, _) -> FMul (remove_pos t1, remove_pos t2)
   | Syntax.FDiv (t1, t2, _, _, _) -> FDiv (remove_pos t1, remove_pos t2)
   | Syntax.Eq (t1, t2, _, _, _) -> Eq (remove_pos t1, remove_pos t2)
   | Syntax.LE (t1, t2, _, _, _) -> LE (remove_pos t1, remove_pos t2)
   | Syntax.If (t1, t2, t3, _, _, _) -> If(remove_pos t1, remove_pos t2, remove_pos t3)
   | Syntax.Let (x_t, t1, t2, _, _, _) -> Let (x_t, remove_pos t1, remove_pos t2)
   | Syntax.Var (id, _, _, _) -> Var(id)
   | Syntax.LetRec (fd, t, _, _, _) -> LetRec(fd_change fd, remove_pos t)
   | Syntax.App (f, args, _, _, _) -> App(remove_pos f, List.map remove_pos args)
   | Syntax.Tuple (t, _, _, _) -> Tuple(List.map remove_pos t)
   | Syntax.LetTuple (x_d, t1, t2, _, _, _) -> LetTuple(x_d, remove_pos t1, remove_pos t2)
   | Syntax.Array (t1, t2, _, _, _) -> Array (remove_pos t1, remove_pos t2)
   | Syntax.Get (t1, t2, _, _, _) -> Get(remove_pos t1, remove_pos t2)
   | Syntax.Put (t1, t2, t3, _, _, _) -> Put(remove_pos t1, remove_pos t2, remove_pos t3)
and
  fd_change fd = (* Syntax.fundef -> Syntax2.fundef *)
    let {Syntax.name = (id, ty); Syntax.args = args_list; Syntax.body = syntax} = fd in
      {name = (id, ty); args = args_list; body = (remove_pos syntax)}
