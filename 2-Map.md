# `map`

Now that we've seen lists, it's useful to be able to perform operations on entire lists of data, rather than one thing at a time.

The `map` function allows us to **transform a list into another list**. It takes two inputs:

- A **function** with signature `X -> Y`, i.e. a function that takes an input of type `X` and returns an input of type `Y`, and
- A **list** of elements of type `X`

and "maps" the function over each item in the input list, returning a **list** of elements of type `Y`.

```scheme
map : (X -> Y), (listof X) -> (listof Y)
```

## Example

Suppose we have our good old function, `doubler`, which takes a number and multiplies it by two.

```scheme
; doubler : number -> number
; takes a number and doubles it
(define doubler
  (lambda (x) (* 2 x)))
```

Now imagine we have the following list of numbers:

```scheme
(list 1 3 -2 0)
```

We want to take this list, double each element, and return the newly-doubled list. We *could* go through the list one element at a time, applying `doubler` to each item and adding the result to a new list:

```scheme
(list (doubler 1)
      (doubler 3)
      (doubler -2)
      (doubler 0))
```

…but that’s a lot of work, and we'd have to write this out manually every time we're given a new list.

Enter `map`.

```scheme
(map doubler (list 1 3 -2 0))
; (list 2 6 -4 0)
```

Let's break down what happens under the hood:

| Item | Current Step | Result So Far |
|----|---|---|
| `1` | `(doubler 1) = 2` | `(list 2)` |
| `3` | `(doubler 3) = 6` | `(list 2 6)` |
| `-2` | `(doubler -2) = -4` | `(list 2 6 -4)` |
| `0` | `(doubler 0) = 0` | `(list 2 6 -4 0)` |

So we can see that calling `(map f list-of-things)` returns the result of transforming `list-of-things` by applying `f` to each element of the list.

<div class="flow-chart"><svg height="99" version="1.1" width="231.796875" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="overflow: hidden; position: relative; top: -0.625px;"><desc style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">Created with RaphaÃ«l 2.1.2</desc><defs style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path><marker id="raphael-marker-endblock33-obj110" markerHeight="3" markerWidth="3" orient="auto" refX="1.5" refY="1.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#raphael-marker-block" transform="rotate(180 1.5 1.5) scale(0.6,0.6)" stroke-width="1.6667" fill="black" stroke="none" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></use></marker><marker id="raphael-marker-endblock33-obj111" markerHeight="3" markerWidth="3" orient="auto" refX="1.5" refY="1.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#raphael-marker-block" transform="rotate(180 1.5 1.5) scale(0.6,0.6)" stroke-width="1.6667" fill="black" stroke="none" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></use></marker></defs><rect x="0" y="0" width="28.3125" height="93" rx="20" ry="20" fill="#ffffff" stroke="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);" stroke-width="2" class="flowchart" id="st" transform="matrix(1,0,0,1,10.7344,4)"></rect><text x="10" y="46.5" text-anchor="start" font-family="sans-serif" font-size="14px" stroke="none" fill="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: start; font-family: sans-serif; font-size: 14px; font-weight: normal;" id="stt" class="flowchartt" font-weight="normal" transform="matrix(1,0,0,1,10.7344,4)"><tspan dy="-21.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">a</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">b</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">c</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">d</tspan></text><rect x="0" y="0" width="40.15625" height="39" rx="0" ry="0" fill="#ffffff" stroke="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);" stroke-width="2" class="flowchart" id="op1" transform="matrix(1,0,0,1,93.8594,31)"></rect><text x="10" y="19.5" text-anchor="start" font-family="sans-serif" font-size="14px" stroke="none" fill="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: start; font-family: sans-serif; font-size: 14px; font-weight: normal;" id="op1t" class="flowchartt" font-weight="normal" transform="matrix(1,0,0,1,93.8594,31)"><tspan dy="5.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">f(x)</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></tspan></text><rect x="0" y="0" width="41.78125" height="93" rx="20" ry="20" fill="#ffffff" stroke="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);" stroke-width="2" class="flowchart" id="e" transform="matrix(1,0,0,1,188.0156,4)"></rect><text x="10" y="46.5" text-anchor="start" font-family="sans-serif" font-size="14px" stroke="none" fill="#000000" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: start; font-family: sans-serif; font-size: 14px; font-weight: normal;" id="et" class="flowchartt" font-weight="normal" transform="matrix(1,0,0,1,188.0156,4)"><tspan dy="-21.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">f(a)</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">f(b)</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">f(c)</tspan><tspan dy="18" x="10" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">f(d)</tspan></text><path fill="none" stroke="#000000" d="M39.046875,50.5C39.046875,50.5,79.38941414654255,50.5,90.85394431416353,50.5" stroke-width="2" marker-end="url(#raphael-marker-endblock33-obj110)" font-family="sans-serif" font-weight="normal" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: sans-serif; font-weight: normal;"></path><path fill="none" stroke="#000000" d="M134.015625,50.5C134.015625,50.5,173.66972494125366,50.5,185.01606408460066,50.5" stroke-width="2" marker-end="url(#raphael-marker-endblock33-obj111)" font-family="sans-serif" font-weight="normal" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: sans-serif; font-weight: normal;"></path></svg></div>

> Since `map` is calling the specified `f` on each item of the specified list, it's important that **the input type of `f` matches the type of `list-of-things`**. Otherwise, we wouldn't be able to evaluate `(f list-item)`.

## Example with structs

```scheme
(define-struct person (name age))

(define CONTACTS (list (make-person "Sarah" 20)
                       (make-person "Ian" 99)
                       (make-person "Bob" 14)
                       (make-person "Joe" 15)))

; age-one-year : person -> person
; returns a new person one year older
(define age-one-year
  (lambda (p)
    (make-person (person-name p)
                 (+ (person-age p) 1))))

(map age-one-year CONTACTS)
; (list (make-person "Sarah" 21)
;       (make-person "Ian" 100)
;       (make-person "Bob" 15)
;       (make-person "Joe" 16))
```

## Example with strings

Consider the following helper function, `append-obama`, which appends "obama" to the end of an input string (very useful for thanking Obama):

```scheme
; append-obama : string -> string
; appends "obama" to the end of a string
(define (append-obama str)
  (string-append str "obama"))
```

Given this helper, suppose we want to produce a list of thank-yous to Obama. We can easily accomplish this using `map`, like so:

```scheme
(map append-obama (list "thanks" "thank you" "thx"))
```

which returns

```scheme
(list "thanksobama" "thank youobama" "thxobama")
```

which is the same thing as

```scheme
(list (append-obama "thanksobama")
      (append-obama "thank youobama")
      (append-obama "thxobama"))
```
