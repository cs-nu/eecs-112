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

- `circle : number, string, string -> image`

And those that take an arbitrary number of arguments:

- `+ : number ... -> number`
- `overlay : image ... -> image`
- `string-append : string ... -> string`

And those that return a different type:

- [`string-length : string -> number`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._string-length%29%29)
- [`number->string : number -> string`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._number-~3estring%29%29)
- [`string-contains? : string, string -> boolean`](https://docs.racket-lang.org/htdp-langs/intermediate.html#%28def._htdp-intermediate._%28%28lib._lang%2Fhtdp-intermediate..rkt%29._string-contains~3f%29%29)

> **On unfamiliar functions:** You may not have seen some of these functions before. Go ahead and try them out in the REPL (Interactions pane) in DrRacket to see what they do.
> 
> Notice that **function signatures give us guidelines for using them**. We know what inputs are valid, even though we don't know what the functions do yet!

## Functions As Inputs and Outputs

In Racket, a function can *take other functions* as inputs, and *return a function* as output. These kinds of super-functions are called **higher-order functions**.

Examples of higher-order functions from class include `iterated-overlay` and `map`.

For instance, consider `iterated-overlay`, which takes:

- An an image-generating function, which will be repeatedly called by `iterated-overlay`
- A number indicating the number of times to call the generating function.

and returns an image.

At first, we might right the signature for `iterated-overlay` like so:

```scheme
iterated-overlay : function number -> image
```

But recall that signatures specify *contracts* for using functions, and it's not very helpful if we don't know what *type* of function to pass into `iterated-overlay`. (Calling `(iterated-overlay + 5)` will definitely not work, for instance.)

So we can nest the signature for the generator function inside the signature for `iterated-overlay` like so:

```scheme
iterated-overlay : (number -> image) number -> image
```

As another example, consider the mathematical differentiation operator $$\frac{d}{dx}$$. It takes a function and returns its derivative, for example:

$$
\begin{aligned}
\frac{d}{dx} \;{\small\begin{matrix}\\ \normalsize (2x^2 + 3x + 1) \\ ^{\small f(x)}\end{matrix} }\;
= \;{\small\begin{matrix}\\ \normalsize 4x + 3 \\ ^{\small f'(x)}\end{matrix} }\;
\end{aligned}
$$

In the example above, the operator $$\frac{d}{dx}$$ takes an input function, and returns an output function. Both the input and output functions themselves take a number $$x$$, and return a number $$f(x)$$.

The input and output functions therefore have the signature `number -> number`.

Accordingly, if we defined the `d/dx` operator for single-variable functions in Racket, its signature would look like this:

```scheme
d/dx : (number -> number) -> (number -> number)
```
