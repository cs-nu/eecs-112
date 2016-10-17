# Function Signatures and Composition

Question: what happens if we try to do the following?

```scheme
(+ 1 "hello")
```

If we try this in DrRacket, we get the following:

```scheme
+: expects a number as 2nd argument, given "hello"
```

Intuitively, it makes sense that this code throws an error; what does it even *mean* to add the number 1 to the word "hello"?

But the contents of the error message reveal something important about functions in Racket: they **expect** arguments to follow a **certain order**, and be of **certain types**.

Let's take a momentary diversion, and consider the game Mad Libs. If you've never played, Mad Libs are stories with random words replaced by blanks. Each blank is labeled with a part of speech (e.g. noun, verb, person's name).

Without reading the story, players fill in the blanks with their own parts of speech. The resulting story is often humorous or nonsensical.

For example, the template

```
[1] Exclamation
[2] Adjective
[3] Noun

"[1]!" Today is a really [2] [3]!
```

might be filled out as follows:

```
"Ouch!" Today is a really fuzzy tree!
```

Notice that although the results may be *nonsensical*, they are still *grammatical*, as long as players *use the correct parts of speech*.

**Racket functions are just like Mad Libs.** Consider the `ellipse` function. We can write its signature like a Mad Lib:

```scheme
[1] Number
[2] Number
[3] Mode (String)
[4] Color (String)

(ellipse [1] [2] [3] [4])
```

which could be filled out as follows:

```scheme
(ellipse 30 50 "outline" "red")
```

Just as you can't write in a verb instead of a noun in Mad Libs, you can't pass a boolean where `ellipse` expects a number, and you can't just change around argument positions depending on how you feel that day. In other words, **you can't violate a function's expectations for its arguments**.

Returning to our earlier example, you can't `+` a number and a string, because `+` expects all of its arguments to be numbers:

```scheme
> (+ 1 "hello")
+: expects a number as 2nd argument, given "hello"
```

You also can't `overlay` an image and a boolean:

```scheme
> (overlay true
           (circle 20 "solid" "blue"))
overlay: expects an image as first argument, given #true
```

We can formalize this idea using **function signatures**. Namely, for each function, we can define the types of each *argument*, as well as its *return type*.

Here is what a signature looks like for a function of two arguments:

```scheme
function-name : arg-type-1, arg-type-2 -> return-type
```

Function signatures provide a much more powerful and specific way to think about function usage and types.

We can write signatures for functions that take a fixed number of arguments:

- `and : boolean, boolean -> boolean`
- `not : boolean -> boolean`

And those that take an arbitrary number of arguments:

- `+ : number ... -> number`
- `overlay : image ... -> image`
- `string-append : string ... -> string`

And those that return a different type:

- [`string-length : string -> number`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._string-length%29%29)
- [`number->string : number -> string`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._number-~3estring%29%29)
- [`string-contains? : string, string -> boolean`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._string-contains~3f%29%29)

And those that take arguments of different types:

- `circle : number, string, string -> image`

> **On unfamiliar functions:** You may not have seen some of these functions before. Go ahead and try them out in the REPL (Interactions pane) in DrRacket to see what they do.
> 
> Notice that **function signatures give us guidelines for using them**. We know what inputs are valid, even though we don't know what the functions do yet!

## Function Composition

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
