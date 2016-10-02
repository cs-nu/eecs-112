# Exercises

The following exercises are by no means comprehensive, but meant to give you some practice putting together the concepts from this section.

For more exercises, [Part One](http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html) of [How to Design Programs, Second Edition](http://www.ccs.neu.edu/home/matthias/HtDP2e/) is excellent.

## Exercise 0

Consider the following functions, `even?` and `and`:

```scheme
; even? : number -> boolean
; returns a boolean indicating whether a number is even
> (even? 4)
#true
> (even? 5)
#false

; and : boolean, boolean -> boolean
; returns true if and only if both arguments are true
> (and true true)
#true
> (and true false)
#false
> (and false false)
#false
```

Use these two functions to write an expression that returns whether `50` and `10` are **both even**.

## Exercise 1

As you know, the `+` function works with any number of numbers, not just two of them:

```scheme
> (+ 1 2 3 4 5 6)
21
```

For this exercise, let's pretend we can't do that.

Write an expression to **sum the integers** 1 through 6, subject to the following constraint:

- Whenever you use `+`, you can only add *two numbers at a time*.

Of course, you can use `+` itself as many times as you want.

## Exercise 2

Write an expression to **convert a number to a string, then convert the string to an image of text**.

You may need to search the `2htdp/image` [documentation](https://docs.racket-lang.org/teachpack/2htdpimage.html) for the `text` function.

## Exercise 3

Consider the following expression:

```scheme
(and (odd? 19)
     (> 4
        (* (string-length "foo")
           2)))
```

1. What is the **return type** of this expression? How do you know?
2. There are five function calls in this expression. **In what order** are they called?
3. What does this expression **simplify** to?

Check your answers using the DrRacket stepper. Then try writing your own complicated expression.
