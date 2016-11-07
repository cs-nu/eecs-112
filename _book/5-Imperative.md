# Imperative Programming

## The Functional Programming Paradigm

Until now, we've been using Racket in the **functional programming** style. Programs written in the functional paradigm are based almost entirely off combining and nesting the results of function calls.

But there's something special about the functions we've been using. They are **pure functions**, which you can think of roughly as "mathematical-style functions."

A function is *pure* if it:

1. Takes *at least one* input, and
2. *Always returns* an output,
3. With the caveat that, given a particular input, the function will *always return the same value* for that input,
    - If $$f(x)$$ is a pure function, calling $$f(3)$$ (for example; could be any number) should always return the same thing.
4. And has *no side effects*.

A function has a **side effect** if it changes another part of the program when it is called. To continue the mathematical analogy, suppose we have a page of calculations and functions, one of which is $$f(x)$$. If we evaluate $$f(3)$$, it (obviously) doesn't change any of the other values on the page.

Likewise, if we evaluate some Racket function `(f 3)`, it doesn't change any of the other values in our program outside of the function itself.

## Imperative Programming

