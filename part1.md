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

1.2:
a.
(define sqrt-lzl (lambda (x init)
    (cons-lzl (cons init (accuracy x init)) (lambda () (sqrt-lzl x (improve init x))))))

(define accuracy (lambda (x guess)
    (abs (- (square guess) x))))

b.
(define find-first
    (lambda (lzl pred)
        (cond ((empty-lzl? lzl) 'fail)
            ((pred (head lzl)) (head lzl))
            (else (find-first (tail lzl) pred)))))
c.
(define sqrt2 (lambda (x init epsilon)
    (car (find-first (sqrt-lzl x init) (lambda (pair) (< (cdr pair) epsilon))))))

# Q2


    