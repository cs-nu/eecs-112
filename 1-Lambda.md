# Defining Functions with `lambda`

Until now, we have only used built-in Racket procedures. To define our own, we'll use the `lambda` keyword.

```scheme
(lambda (<Input1> <Input2> ... <InputN>) <Body>)

; Most of the time, we put <Body> on a new line to make things more readable.
; The following pattern is identical to the previous one, just with a newline.
(lambda (<Input1> <Input2> ... <InputN>)
    <Body>)
```

So we can use `lambda` to create a function by giving it the following "chunks":

1. A parenthetical sequence of **inputs** (also known as **arguments** or **parameters**), and
2. Some kind of expression, the **body** of the function.

Here are some quick examples of `lambdas` and their [signatures](./0-Signatures.html).

```scheme
; number -> number
; returns x, doubled
(lambda (x) (* 2 x))

; string -> string
; wishes happy birthday to someone
(lambda (name)
  (string-append "Happy birthday, " name "!"))
```

## Anonymous Functions

Calling `lambda` creates an *anonymous* function. By "anonymous", we literally mean "nameless"; our function doesn't have a name we can use to call it.

To understand this more thoroughly, consider the following mathematical function $$f$$:

$$
f(x) = 2x
$$

The Racket equivalent of $$f$$ is the following:

```scheme
(define f
  (lambda (x) (* 2 x)))
```

We can decompose each of these function declarations into two chunks: the **name**, and the **lambda**:

$$
\;{\small\begin{matrix}\\ \normalsize f \\ ^{\small \text{name}}\end{matrix} }\;
\;{\small\begin{matrix}\\ \normalsize (x) = 2x \\ ^{\small \text{lambda}}\end{matrix} }\;
$$

```scheme
(define f  ; name
  (lambda (x) (* 2 x)))  ; lambda
```

**Notice that we've added a `(define f ...` to our `lambda`.**

`define` attaches a name, `f`, to our anonymous `lambda`. Now we can reference our function later on, by calling `(f <number>)`.

To illustrate the importance of what just happened, consider the mathematical version of $$f$$. If we wanted to call $$f$$ with a bunch of inputs for $$x$$, we might write something like

$$
\begin{aligned}
    f(3) \\
    f(4) \\
    f(5)
\end{aligned}
$$

which is a lot cleaner and more succinct than writing

$$
\begin{aligned}
    \big( (x) = 2x \big)(3) \\
    \big( (x) = 2x \big)(4) \\
    \big( (x) = 2x \big)(5)
\end{aligned}
$$

To be clear, **the above math is perfectly legal**. It just looks weird because nobody ever does that.

Notice that although the short and verbose function calls are exactly equivalent, using the **function name** $$f$$ gives us a handy way to reference the **lambda part**.

This logic translates directly to Racket. Here's how we'd call `f` a bunch of times:

```scheme
; named version
(define f
  (lambda (x) (* 2 x)))

(f 3)  ; 6
(f 4)  ; 8
(f 5)  ; 10
```

Again, this is much more succinct than calling the lambda anonymously:

```scheme
; anonymous version
(lambda (x) (* 2 x))

((lambda (x) (* 2 x)) 3)  ; 6
((lambda (x) (* 2 x)) 4)  ; 8
((lambda (x) (* 2 x)) 5)  ; 10
```

(Once again, **writing the whole `lambda` out each time is cumbersome, but perfectly legal**. You can try this in DrRacket and it will work.)

> **Note:** The anonymous function calls are pretty difficult to read. Consider this one:
> 
> ```scheme
> ((lambda (x) (* 2 x)) 3)  ; 6
> ```
> 
> Remember that the Racket syntax for calling any function is just
> 
> ```scheme
> (<Function> <Input1> <Input2> ...)
> ```
> 
> So we call our anonymous `lambda` the same way:
> 
> - `<Function>` becomes `(lambda (x) (* 2 x))`
> - `<Input1>` becomes `3` (there is only one `<Input>`)
> 
> and everything is wrapped in a set of parentheses to signal to Racket
> that we are **calling** the function.

## Function Evaluation

What actually happens when we call `(f 3)`, anyways? Let's return to our trusty mathematical function for comparison.

1. **Look up the full definition** of our function.
2. **Plug in the input values** wherever they appear in the function body.
3. **Ignore the "function baggage"** and focus on the body, now that we've plugged everything in.
4. **Simplify the resulting expression** using order of operations, and return the result.
        
| Step               | Math $$f(3)$$  | Racket `(f 3)`         |
|--------------------|----------------|------------------------|
| Look up definition | $$(x) = 2x$$   | `(lambda (x) (* 2 x)`  |
| Plug in inputs     | $$(3) = 2(3)$$ | `(lambda (3) (* 2 3))` |
| Focus on body      | $$2(3)$$       | `(* 2 3)`              |
| Simplify           | $$6$$          | `6`                    |

## More Examples

We used a really simple function to demonstrate the parallels between mathematical function definitions, and Racket function definitions. Here are some more examples.

### Using more expressive names

In math, we're pretty much limited to single-letter function names like $$f$$ or $$g$$. In Racket, we can be a lot more descriptive with our naming.

```scheme
(define doubler
  (lambda (x) (* 2 x)))
```

The same goes for our arguments. While the above function works for doubling numbers generically, suppose we want to write a function designed specifically to double the *width* of a shape.

```scheme
(define doubler
  (lambda (width) (* 2 width)))  ; much clearer
```

### Multivariable functions

Just as we have multivariable functions in math, we have multivariable functions in Racket.

$$
g(x, y, z) = x^2 + y^2 + z
$$

translates to

```scheme
(define g
  (lambda (x y z)
    (+ (sqr x) (sqr y) z)))

(g 1 2 3)  ; 8
```

The same evaluation pattern works for multivariable functions.

| Step               | Math $$g(1, 2, 3)$$           | Racket `(g 1 2 3)`         |
|--------------------|-------------------------------|------------------------|
| Look up definition of $$g$$ | $$(x, y, z) = x^2 + y^2 + z$$ | `(lambda (x y z) (+ (sqr x) (sqr y) z))`  |
| Plug in inputs     | $$(1, 2, 3) = (1)^2 + (2)^2 + (3)$$ | `(lambda (1 2 3) (+ (sqr 1) (sqr 2) 3))`  |
| Focus on body      | $$(1)^2 + (2)^2 + (3)$$       | `(+ (sqr 1) (sqr 2) 3)` |
| Simplify           | $$1 + 4 + 3 = 8$$    | `(+ 1 4 3) = 8` |

Here's another example. Using the Pythagorean Theorem, we can write a function to compute the length of the hypotenuse, given two legs of a triangle:

$$
hypotenuse(x, y) = \sqrt{x^2 + y^2}
$$

which translates to Racket as

```scheme
(define hypotenuse
  (lambda (x y)
    (sqrt (+ (sqr x)
             (sqr y)))))

(hypotenuse 3 4)  ; 5
```

| Step               | Math $$hypotenuse(3, 4)$$           | Racket `(hypotenuse 3 4)`         |
|--------------------|-------------------------------|------------------------|
| Look up definition | $$(x, y) = \sqrt{x^2 + y^2}$$ | `(lambda (x y) (sqrt (+ (sqr x) (sqr y))))`  |
| Plug in inputs     | $$(3, 4) = \sqrt{(3)^2 + (4)^2}$$ | `(lambda (3 4) (sqrt (+ (sqr 3) (sqr 4))))`  |
| Focus on body      | $$\sqrt{(3)^2 + (4)^2}$$       | `(sqrt (+ (sqr 3) (sqr 4)))` |
| Simplify           | $$\sqrt{9 + 16} = \sqrt{25} = 5$$    | `(sqrt (+ 9 16)) = (sqrt 25) = 5` |

### Functions on non-numerical data types

We've mostly looked at functions with the signature

```
number -> number
```

so far. But functions can take any inputs and return any outputs. Here are more examples.

```scheme
; has-even-length? : string -> boolean
; returns true if the given string has an even number of characters
(define has-even-length?
  (lambda (str)
    (even? (string-length str))))

(has-even-length? "eecs")  ; true
(has-even-length? "lol")  ; false
(has-even-length? "k bye!")  ; true
```

| Step               | `(has-even-length "eecs")`         |
|--------------------|------------------------------------|
| Look up definition | `(lambda (str) (even? (string-length str)))`  |
| Plug in inputs     | `(lambda ("eecs") (even? (string-length "eecs")))` |
| Focus on body      | `(even? (string-length "eecs"))` |
| Simplify           | `(even? 4) = true` |

```scheme
; mad-lib : string, string, string -> number
; returns a sentence with the given noun, verb, and adjective
(define mad-lib
  (lambda (noun verb adj)
    (string-append "I " verb " to Tech Express and buy a " adj " " noun ".")))

(mad-lib "dignity" "gallop" "new")  ; "I gallop to Tech Express and buy a new dignity."
```
