# Q1
1.1:

a. For  two lazy lists Lzl1, Lzl2, we say that Lzl1~Lzl2 if:
Lzl1 = Lzl2 = '()
Or
(head Lzl1) = (head Lzl2) & (tail Lzl1) ~ (tail Lzl2)

b. We will prove in induction on i - index of the value:

Base case i = 0:
For even-square-1, the first element generated is 0, its square is 0, and since 0 % 2 = 0, it passes the filter so the first head is 0.
For even-square-2, the first element generated is 0, since 0 % 2 = 0, it passes the filter, and its square is 0 so the first head is 0.

Inductive Step:
Assume that the i-th element successfully generated in both lists is identical, and it resulted from processing the original number 2i (yielding the value (2i)^2).

Evaluating the next number, 2i + 1 (an odd number):
even-square-1 maps the number to (2i+1)^2. Because the square of an odd number is always odd, the filter predicate (= (modulo x 2) 0) evaluates to #f, and the element is discarded.  
even-square-2 applies the filter directly to 2i+1. Since it is odd, the predicate returns #f, discarding the number before any mapping occurs.  

Evaluating the subsequent number, 2i + 2 (an even number):
even-square-1 maps the number to (2i+2)^2. Because the square of an even number is strictly even (a multiple of 4), it passes the filter predicate (= (modulo x 2) 0) and is accepted as the new head.  
even-square-2 applies the filter to 2i+2. Since it is an even number, it passes. It is then mapped to its square, resulting in (2i+2)^2.  
The (i+1)-th element in both lists is exactly identical: (2i+2)^2. 

Conclusion: By the principle of mathematical induction, for every valid index i, the heads of both lists are identical at that step (Lzl1.head = Lzl2.head). Because the underlying evaluation steps taken to arrive at the next valid element are identical in their outcomes (as proven by the inductive step), it is guaranteed that Lzl1.tail ~ Lzl2.tail.Consequently, even-square-1 is equivalent to even-square-2 according to your definition.

# Q2
a.
For f : X1 × X2 × … × Xn → T ∪ {'fail}
=>  f_sfc : x1 x x2 x ... x xn x [T -> Tsuccess] x [Empty -> Tfail] -> [Tsuccess U Tfail]

for each v: 
    f(args) = v -> f_sfc(args, S, F) = S(v)
    f(args) = fail -> f_sfc(args, S, F) = F()
    
d. 
Claim: For every list l=(x1,...,xn), key k,
    for every i s.t. for every j < i l[j].symbol != k:
        get-value(l, k) = get-value((xi,...,xn), k).
        get-value$(l, k, S, F) = get-value$((xi,...,xn), k, S, F).

Claim proof:
    Base case: i = 1 (trivial)
        get-value(l, k) = get-value((x1,...,xn), k)
        get-value$(l, k, S, F) = get-value$((x1,...,xn), k, S, F)
    Induction step: Let i.
        From induction assumption,
            get-value(l, k) = get-value((xi-1, xi,...,xn), k) = get-value((xi,...,xn), k)
            get-value$(l, k, S, F) = get-value$((xi-1, xi,...,xn), k, S, F) = get-value$((xi,...,xn), k, S, F)

Prove:
    Let l list l=(x1,...,xn), key k, funcs S, F.
    If for every i, xi.symbol != k, from claim we get:
        get-value(l, k) = get-value((xn), k) = get-value('(), k) = 'fail.
        get-value$(l, k, S, F) = get-value$((xn), k, S, F) = get-value$('(), k, S, F) = F().
    else, let i be the first index s.t. xi.symbol = k. Then from claim we get:
        get-value(l, k) = get-value((xi,...,xn), k) = xi.value.
        get-value$(l, k, S, F) = get-value$((xi,...,xn), k, S, F) = S(xi.value).

# Q3
3.1:
1. unify[t(s(s), G, s, p, t(K), s), t(s(G), G, s, p, t(K), U)]
=>
Choose t(s(s), G, s, p, t(K), s) = t(s(G), G, s, p, t(K), U)
->
* s(s) = s(G)
* G = G
* s = s
* p = p
* t(K) = t(K)
* s = U

sub = {}

=>
Choose s(s) = s(G)
->
* s = G
G = G
s = s
p = p
t(K) = t(K)
s = U

sub = {}

=>
Choose s = G
->
G = G
s = s
p = p
t(K) = t(K)
s = U

* sub = {G = s}

=>
Choose G = G
->
* (delete)
s = s
p = p
t(K) = t(K)
s = U

sub = {G = s}

=>
Choose s = s
->
* (delete)
p = p
t(K) = t(K)
s = U

sub = {G = s}

=>
Choose p = p
->
* (delete)
t(K) = t(K)
s = U

sub = {G = s}

=>
Choose t(K) = t(K)
->
* K = K
s = U

sub = {G = s}

=>
Choose K = K
->
* (delete)
s = U

sub = {G = s}

=>
Choose s = U
->

* sub = {G = s, U = s}

Then, sub = {s = G, U = s}.

2. unify[g(l,M,g,G,U,g,v(M)), g(l,v(U),g,v(M),v(G),g,v(M))]
=>
Choose g(l,M,g,G,U,g,v(M)) = g(l,v(U),g,v(M),v(G),g,v(M))
->
* l = l
* M = v(U)
* g = g
* G = v(M)
* U = v(G)
* g = g
* v(M) = v(M)

sub = {}

=>
Choose l = l
->

* (delete)
M = v(U)
g = g
G = v(M)
U = v(G)
g = g
v(M) = v(M)

sub = {}

=>
Choose M = v(U)
->

g = g
* G = v(v(U))
U = v(G)
g = g
* v(v(U)) = v(v(U))

* sub = {M = v(U)}

=>
Choose G = v(v(U))
->

g = g
* U = v(v(v(U)))
g = g
v(v(U)) = v(v(U))

* sub = {M = v(U), G = v(v(U))}

=>
Choose U = v(v(v(U)))
->

Failure: infinite loop

3. unify[m(M,N), n(M,N)]
=>
Choose m(M,N) = n(M,N)
->
* m = n

sub = {}

=>
Choose m = n
->
Failure: Predicate Mismatch

4. unify[p([v | [V | VV]]), p([[v | V] | VV])]
=>
Choose p([v | [V | VV]]) = p([[v | V] | VV])
->
* [v | [V | VV]] = [[v | V] | VV]

=>
Choose [v | [V | VV]] = [[v | V] | VV]
->
* 