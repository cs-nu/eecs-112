Here is the template for a general recursive procedure:

```scheme
(define general-recursive-procedure
  (lambda (input)
    (if <BaseCase>
        <BaseCaseResult>
        <RecursiveStep>)))
```

Here is the template for a general recursive procedure on lists:

```scheme
(define list-recursive-procedure
  (lambda (lst)
    (if
     ; <BaseCase>
     (empty? lst)
     ; <BaseCaseResult>
     0  ; or whatever makes sense for an empty list
     ; <RecursiveStep>
     (...(first lst)...(list-recursive-procedure (rest lst))...))))
```

Here is the template for a general recursive procedure on numbers:

```scheme
(define number-recursive-procedure
  (lambda (lst)
    (if
     ; <BaseCase>
     (empty? lst)
     ; <BaseCaseResult>
     0  ; or whatever makes sense for an empty list
     ; <RecursiveStep>
     (...(first lst)...(list-recursive-procedure (rest lst))...))))
```

```scheme
; count-items : (listof any) -> number
; returns the number of items in a list
(define count-items
  (lambda (lst)
    (if
     ; Base Case: an empty list has 0 items
     (empty? lst) 0
     ; Recursive Step: 1 + the number of items in the tail
     (+ 1
        (count-items (rest lst))))))
```

```scheme
; fib(0) = 1
; fib(1) = 1
; fib(n) = fib(n - 1) + fib(n - 2), n > 1

; fib : number -> number
; computes the nth fibonacci number
(define fib
  (lambda (n)
    (if
     ; base case: n = 0 or n = 1
     (or (eq? n 1)
         (eq? n 0))
     ; what to do in the base case: return 1
     1
     ; recursive step: return fib(n - 1) + fib(n - 2)
     (+ (fib (- n 1))
        (fib (- n 2))))))
```
