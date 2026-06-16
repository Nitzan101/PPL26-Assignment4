# Q1.1
1. {f:(T1 -> T2), g:(T1 -> T2), a: T1} ⊢ (f (g a)):T2
False:
{g:(T1 -> T2), a: T1} ⊢ (g a): T2
then (f T2) is a Type error for {f:(T1 -> T2)}.
2. {f:(T1 * T2 -> T3)} ⊢ (lambda (x) (f x y)): (T2 -> T3)
False:
f receives (T1 * T2) then in (f x y) x should be T1 so (lambda (x) (f x y)) is (T1 -> T3)
3. {f:(T1 * T2 -> T3), y: T2} ⊢ (lambda (x) (f x y)): (T1 -> T3)
False: 
maybe x isn't T1.

# Q1.2
1. (lambda (f1 g1 x1 y1) (f1 (g1 y1 x1) (g1 x1 y1)))

T0: (lambda (f g x y) (f (g y x) (g x y)))
T1: (f (g y x) (g x y))
T2: (g y x)
T3: (g x y)
Tf: f
Tg: g
Tx: x
Ty: y

Equations:

sub = {}

T0: [Tf * Tg * Tx * Ty -> T1]
Tf: [T2 * T3 -> T1]
Tg: [Ty * Tx -> T2]
Tg: [Tx * Ty -> T3]

=>

sub = {T0 = [Tf * Tg * Tx * Ty -> T1]}

Tf: [T2 * T3 -> T1]
Tg: [Ty * Tx -> T2]
Tg: [Tx * Ty -> T3]

=>

sub = {T0 = [[T2 * T3 -> T1] * Tg * Tx * Ty -> T1],
       Tf: [T2 * T3 -> T1]}

Tg: [Ty * Tx -> T2]
Tg: [Tx * Ty -> T3]

=>

sub = {T0 = [[T2 * T3 -> T1] * [Ty * Tx -> T2] * Tx * Ty -> T1],
       Tf = [T2 * T3 -> T1],
       Tg = [Ty * Tx -> T2]}

Tg: [Tx * Ty -> T3]

=>

sub = {T0 = [[T2 * T3 -> T1] * [Ty * Tx -> T2] * Tx * Ty -> T1],
       Tf = [T2 * T3 -> T1],
       Tg = [Ty * Tx -> T2]}

Ty = Tx
Tx = Ty
T2 = T3

=>

sub = {T0 = [[T2 * T3 -> T1] * [Tx * Tx -> T2] * Tx * Tx -> T1],
       Tf = [T2 * T3 -> T1],
       Tg = [Tx * Tx -> T2],
       Ty = Tx}

Tx = Ty
T2 = T3

=>

sub = {T0 = [[T2 * T3 -> T1] * [Ty * Ty -> T2] * Ty * Ty -> T1],
       Tf = [T2 * T3 -> T1],
       Tg = [Ty * Ty -> T2],
       Tx = Ty}

T2 = T3

=>

sub = {T0 = [[T3 * T3 -> T1] * [Ty * Ty -> T3] * Ty * Ty -> T1],
       Tf = [T3 * T3 -> T1],
       Tg = [Ty * Ty -> T3],
       Tx = Ty,
       T2 = T3}

The inference succeeds.

2. ((lambda (f1) (lambda (x1) (f1 x1 x1))) (lambda (y1) y1))

T0: ((lambda (f) (lambda (x) (f x x))) (lambda (y) y))
T1: (lambda (f) (lambda (x) (f x x)))
T2: (lambda (y) y)
T3: (lambda (x) (f x x))
T4: (f x x)
Tf: f
Tx: x
Ty: y

Equations:

sub = {}

T1: [T2 -> T0]
T1: [Tf -> T3]
T2: [Ty -> Ty]
T3: [Tx -> T4]
Tf: [Tx * Tx -> T4]

=>

sub = {T1: [T2 -> T0]}

T1: [Tf -> T3]
T2: [Ty -> Ty]
T3: [Tx -> T4]
Tf: [Tx * Tx -> T4]

=>

sub = {T1: [T2 -> T0]}

T2: [Ty -> Ty]
T3: [Tx -> T4]
Tf: [Tx * Tx -> T4]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty]}

T3: [Tx -> T4]
Tf: [Tx * Tx -> T4]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4]}

Tf: [Tx * Tx -> T4]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       Tf = [Tx * Tx -> T4]}

T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       Tf = [Tx * Tx -> T4]}

T0 = T3
Tf = [Ty -> Ty]

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       Tf = [Tx * Tx -> T4]}

T0 = [Tx -> T4]
Tf = [Ty -> Ty]

=>

sub = {T1 = [[Ty -> Ty] -> [Tx -> T4]],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       Tf = [Tx * Tx -> T4],
       T0 = [Tx -> T4]}

Tf = [Ty -> Ty]

=>

sub = {T1 = [[Ty -> Ty] -> [Tx -> T4]],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       Tf = [Tx * Tx -> T4],
       T0 = [Tx -> T4]}

[Tx * Tx] = Ty
T4 = Ty

=>

the inference fails because the algorithm is trying to solve the conflicting equation [Tx * Tx] = Ty
The inference fails because we must unify [Ty -> Ty] (a 1-parameter procedure) with [Tx * Tx -> T4] (a 2-parameter procedure). These have incompatible arities and cannot be unified.

3. ((lambda (f1) (lambda (x1) ((f1 x1) x1))) (lambda (y1) y1))

T0: ((lambda (f) (lambda (x) ((f x) x))) (lambda (y) y))
T1: (lambda (f) (lambda (x) ((f x) x)))
T2: (lambda (y) y)
T3: (lambda (x) ((f x) x))
T4: ((f x) x)
T5: (f x)
Tf: f
Tx: x
Ty: y

Equations:

sub = {}

T1: [T2 -> T0]
T1: [Tf -> T3]
T2: [Ty -> Ty]
T3: [Tx -> T4]
T5: [Tx -> T4]
Tf: [Tx -> T5]

=>

sub = {T1 = [T2 -> T0]}

T1: [Tf -> T3]
T2: [Ty -> Ty]
T3: [Tx -> T4]
T5: [Tx -> T4]
Tf: [Tx -> T5]

=>

sub = {T1 = [T2 -> T0]}

T2: [Ty -> Ty]
T3: [Tx -> T4]
T5: [Tx -> T4]
Tf: [Tx -> T5]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty]}

T3: [Tx -> T4]
T5: [Tx -> T4]
Tf: [Tx -> T5]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4]}

T5: [Tx -> T4]
Tf: [Tx -> T5]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       T5 = [Tx -> T4]}

Tf: [Tx -> T5]
T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       T5 = [Tx -> T4],
       Tf = [Tx -> T5]}

T2 = Tf
T0 = T3

=>

sub = {T1 = [[Ty -> Ty] -> T0],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       T5 = [Tx -> T4],
       Tf = [Tx -> T5]}

T0 = T3
Tf = [Ty -> Ty]

=>

sub = {T1 = [[Ty -> Ty] -> T3],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       T5 = [Tx -> T4],
       Tf = [Tx -> T5],
       T0 = T3}

Tf = [Ty -> Ty]

=>

sub = {T1 = [[Ty -> Ty] -> T3],
       T2 = [Ty -> Ty],
       T3 = [Tx -> T4],
       T5 = [Tx -> T4],
       Tf = [Tx -> T5],
       T0 = T3}

Tx = Ty
T5 = Ty

=>

sub = {T1 = [[Ty -> Ty] -> T3],
       T2 = [Ty -> Ty],
       T3 = [Ty -> T4],
       T5 = [Ty -> T4],
       Tf = [Ty -> T5],
       T0 = T3,
       Tx = Ty}

T5 = Ty

=>

sub = {T1 = [[Ty -> Ty] -> T3],
       T2 = [Ty -> Ty],
       T3 = [Ty -> T4],
       T5 = [Ty -> T4],
       Tf = [Ty -> T5],
       T0 = T3,
       Tx = Ty}

Ty = [Ty -> T4]

=>

the inference fails because the algorithm is trying to solve the conflicting equation Ty = [Ty -> T4]

# Q1.3
(lambda (f) (f (right (lambda (s) (f (left s))))))

T0: (lambda (f) (f (right (lambda (s) (f (left s))))))
T1: (f (right (lambda (s) (f (left s)))))
T2: (right (lambda (s) (f (left s))))
T3: (lambda (s) (f (left s)))
T4: (f (left s))
T5: (left s)
Tf: f
Ts: s

Equations:

sub = {}

T0: [Tf -> T1]
Tf: [T2 -> T1]
T2: [T6 + T3]
T3: [Ts -> T4]
Tf: [T5 -> T4]
T5: [Ts + T7]
T6
T7

=>

sub = {T0 = [Tf -> T1]}

Tf: [T2 -> T1]
T2: [T6 + T3]
T3: [Ts -> T4]
Tf: [T5 -> T4]
T5: [Ts + T7]

=>

sub = {T0 = [[T2 -> T1] -> T1],
       Tf = [T2 -> T1]}

T2: [T6 + T3]
T3: [Ts -> T4]
Tf: [T5 -> T4]
T5: [Ts + T7]

=>

sub = {T0 = [[[T6 + T3] -> T1] -> T1],
       Tf = [[T6 + T3] -> T1],
       T2 = [T6 + T3]}

T3: [Ts -> T4]
Tf: [T5 -> T4]
T5: [Ts + T7]

=>

sub = {T0 = [[[T6 + [Ts -> T4]] -> T1] -> T1],
       Tf = [[T6 + [Ts -> T4]] -> T1],
       T2 = [T6 + [Ts -> T4]],
       T3 = [Ts -> T4]}

Tf: [T5 -> T4]
T5: [Ts + T7]

=>

sub = {T0 = [[[T6 + [Ts -> T4]] -> T1] -> T1],
       Tf = [[T6 + [Ts -> T4]] -> T1],
       T2 = [T6 + [Ts -> T4]],
       T3 = [Ts -> T4]}

T5: [Ts + T7]
[T6 + [Ts -> T4]] = T5
T1 = T4

=>

sub = {T0 = [[[T6 + [Ts -> T4]] -> T1] -> T1],
       Tf = [[T6 + [Ts -> T4]] -> T1],
       T2 = [T6 + [Ts -> T4]],
       T3 = [Ts -> T4],
       T5 = [Ts + T7]}

[T6 + [Ts -> T4]] = T5
T1 = T4

=>

sub = {T0 = [[[T6 + [Ts -> T4]] -> T1] -> T1],
       Tf = [[T6 + [Ts -> T4]] -> T1],
       T2 = [T6 + [Ts -> T4]],
       T3 = [Ts -> T4],
       T5 = [Ts + T7]}
       
T1 = T4
Ts = T6
T7 = [Ts -> T4]

=>

sub = {T0 = [[[T6 + [Ts -> T4]] -> T4] -> T4],
       Tf = [[T6 + [Ts -> T4]] -> T4],
       T2 = [T6 + [Ts -> T4]],
       T3 = [Ts -> T4],
       T5 = [Ts + T7],
       T1 = T4}
       
Ts = T6
T7 = [Ts -> T4]

=>

sub = {T0 = [[[T6 + [T6 -> T4]] -> T4] -> T4],
       Tf = [[T6 + [T6 -> T4]] -> T4],
       T2 = [T6 + [T6 -> T4]],
       T3 = [T6 -> T4],
       T5 = [T6 + T7],
       T1 = T4,
       Ts = T6}
       
T7 = [Ts -> T4]

=>

sub = {T0 = [[[T6 + [T6 -> T4]] -> T4] -> T4],
       Tf = [[T6 + [T6 -> T4]] -> T4],
       T2 = [T6 + [T6 -> T4]],
       T3 = [T6 -> T4],
       T5 = [T6 + [T6 -> T4]],
       T1 = T4,
       Ts = T6,
       T7 = [T6 -> T4]}

The inference succeeds.