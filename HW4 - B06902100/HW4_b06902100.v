Require Import Znumtheory .
Require Import Zdiv .
Require Import ZArith .
Import Z.

Section SimpleChineseRemainder .

Open Scope Z_scope .

Definition modulo (a b n : Z) : Prop := (n | (a - b)) .
Notation "( a == b [ n ])" := (modulo a b n) .

Lemma modulo_tran : forall a b c n : Z, 
    (a == b [ n ]) -> (b == c [ n ]) -> (a == c [ n ]) .
Proof .
  intros a b c n Hab Hbc .
  red in Hab, Hbc |- * .
  cut (a - c = a - b + (b - c)) .
  - intros H .
    rewrite H .
    apply Zdivide_plus_r .
    + trivial .
    + trivial .
  - auto with * .
Qed .

Lemma modulo_plus_subst : forall a b c n : Z,
    (a == b [ n ]) -> (a + c == b + c [ n ]) .
Proof .
  intros a b c n Hab.
  red in Hab |- *.
  cut (a + c - (b + c) = a - b).
    intros H.
    rewrite H.
    trivial.
    auto with *.
Qed .

Lemma modulo_mult_subst : forall a b c n : Z,
    (a == b [ n ]) -> (a * c == b * c [ n ]) .
Proof .
  intros a b c n Hab. 
  red in Hab |- *.
  cut (a*c - b*c = (a-b) * c).
    intros H.
    rewrite H.
    apply divide_mul_l.
    trivial.
    auto with *.
Qed .


Hypothesis m n : Z .
Hypothesis co_prime : rel_prime m n .

Theorem modulo_inv : forall m n : Z, rel_prime m n ->
                       exists x : Z, (m * x == 1 [ n ]) .
Proof .
  intros m0 n0 Hrel_prime.
  elim (Zis_gcd_bezout m0 n0 1).
    intros u v Heq.
    exists u.
    rewrite mul_comm.
    apply divide_add_cancel_r with (m := v * n0).
    apply divide_factor_r.
    rewrite add_sub_assoc, add_comm, Heq.
    rewrite sub_diag.
    apply divide_0_r.
    trivial.
Qed .

Theorem SimpleChineseRemainder : forall a b : Z,
  exists x : Z, (x == a [ m ]) /\ (x == b [ n ]) .
Proof .
(* to be done *)
  intros a b.
    (* case : (a * v * n + b * u * m) == a [m] *)
    destruct (rel_prime_bezout _ _ co_prime) as [u v Heq].
    exists (a * v * n + b * u * m).
    split.
      apply add_move_l in Heq.
      rewrite <- mul_assoc.
      rewrite Heq.
      rewrite mul_sub_distr_l.
      rewrite mul_assoc.
      rewrite <- add_sub_swap.
      rewrite <- add_sub_assoc.
      rewrite <- mul_sub_distr_r.
      red.
      rewrite add_sub_swap.
      apply divide_add_r.
      rewrite mul_1_r.
      rewrite sub_diag.
      apply divide_0_r.
      apply divide_factor_r.
      
    (* case : (a * v * n + b * u * m) == b [n] *)
      rewrite add_comm.
      apply add_move_r in Heq.
      rewrite <- mul_assoc.
      rewrite Heq, mul_sub_distr_l, mul_assoc.
      rewrite <- add_sub_swap, <- add_sub_assoc, <- mul_sub_distr_r.
      red.
      rewrite add_sub_swap.
      apply divide_add_r.
      rewrite mul_1_r.
      rewrite sub_diag.
      apply divide_0_r.
      apply divide_factor_r.
    
Qed .

End SimpleChineseRemainder .

Check SimpleChineseRemainder .