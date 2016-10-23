# Function Composition

Recall that a function signature is comprised of two main parts. Everything to the *left* of the arrow `->` indicates the types of the function's arguments, and the *right* indicates the function's **return type**.

Thus far, we've mostly focused on the argument types. Let's turn our attention to the return type.

```scheme
; number->string : number -> string
> (number->string 524)
"524"
```

In this example, we've used the `number->string` function to convert a number, `524`, into its string representation, `"524"` (remember, they are different types, and therefore different data).

Notice what happens here:

```scheme
> (string-append "ted cruz"
                 524
                 "zodiac killer")
string-append: expects a string as 2nd argument, given 524

> (string-append "ted cruz"
                 (number->string 524)
                 "zodiac killer")
"ted cruz524zodiac killer"
```

What just happened? Let's deconstruct this in the stepper.

First, we evaluating the innermost expression. `(number->string 524)` simplifies to `"524"`:

```scheme
(string-append "ted cruz"
               (number->string 524)
               "zodiac killer")
```

becomes

```scheme
(string-append "ted cruz"
               "524"
               "zodiac killer")
```

Now, we can `string-append` everything together:

```scheme
"ted cruz524zodiac killer"
```

Fair enough. Let's take a look at the function signatures for `number->string` and `string-append`:

- `number->string : number -> string`
- `string-append : string ... -> string`

Notice how our initial attempt fails because we've violated the `string-append` function signature by passing in a number.

Our second try succeeds, because we first convert `524` to a string. Then, when `string-append` is called, **all of its arguments are strings**.

How do we know this? Because the **function signature for `number->string` guarantees it will return a string**.

In this sense, we can think of function signatures as "contracts" for function usage.

> Function signatures dictate that
> 
> - as long as we provide arguments of the correct type, in the correct order,
> - we can **count on the function to return a specific type**.

This contract, coupled with the rules for program evaluation we've already seen, form the basis for programming in Racket. **If you internalize these two things, everything in this class will make sense.**
