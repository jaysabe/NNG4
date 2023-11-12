import Game.MyNat.Addition-- makes simps work?
import Game.MyNat.PeanoAxioms
import Game.Levels.Algorithm.L07succ_ne_succ
import Mathlib.Tactic
import Game.Tactic.decide

namespace MyNat

-- to get numerals of type MyNat to reduce to MyNat.succ (MyNat.succ ...)
@[MyNat_decide]
lemma ofNat_succ : (OfNat.ofNat (Nat.succ n) : ℕ) = MyNat.succ (OfNat.ofNat n) := _root_.rfl

instance instDecidableEq : DecidableEq MyNat
| 0, 0 => isTrue <| by
  show 0 = 0
  rfl
| succ m, 0 => isFalse <| by
  show succ m ≠ 0
  exact succ_ne_zero m
| 0, succ n => isFalse <| by
  show 0 ≠ succ n
  exact zero_ne_succ n
| succ m, succ n =>
  match instDecidableEq m n with
  | isTrue (h : m = n) => isTrue <| by
    show succ m = succ n
    rw [h]
    rfl
  | isFalse (h : m ≠ n) => isFalse <| by
    show succ m ≠ succ n
    exact succ_ne_succ m n h
