# Evaluating Expressions and Function Calls

By now, you should have tried evaluating some simple expressions in DrRacket. When you type some code and hit `Run`, DrRacket "thinks" for a bit, before outputting the result.

These notes are designed to help you **build an intuitive mental model of what happens in the "thinking" stage**. Program evaluation can seem overly "magical" if you've never programmed before, but it turns out that Racket's evaluation process follows a set of *extremely simple rules* that follow from either intuition or grade school math.

If you haven't done so already, try using the DrRacket **stepper** on a nested expression like this:

```scheme
(+ 1 2 (+ 3 4))
```

The stepper can be accessed by clicking the "Step through" button in the upper right of the definitions window. It walks you through the process of evaluating your program, step-by-step (as the name would suggest).

The rest of these notes will establish more formal guidelines for program evaluation in Racket, but it helps to have a loose idea about how things work.

## Calling Functions

**Functions** (also called **procedures**) are the bread and butter of Racket programming.

Recall that a function in math is something like this:
$$
f(x) = x^2
$$

where $$f$$ takes a single input, $$x$$, and transforms it into another number, $$x^2$$.

In Racket, we have a function called [`sqr`](https://docs.racket-lang.org/htdp-langs/intermediate-lam.html#%28def._htdp-intermediate-lambda._%28%28lib._lang%2Fhtdp-intermediate-lambda..rkt%29._sqr%29%29). Just like $$f$$, `sqr` takes a single input (called an **argument** or **parameter**) and returns the square of that input.

```scheme
> (sqr 2)
4
```

Of course, some functions in math can have multiple arguments, like

$$
f(x, y) = 2x + y
$$

Similarly, Racket has functions that take multiple arguments. Consider the function `+`, which returns the sum of all of its inputs (in this regard, the Racket `+` function is a lot closer to the mathematical sum $$\Sigma$$ than the addition operator $$+$$).

```scheme
> (+ 1 2 3)
6
```

In math, we have a clear notation for applying a function to an input. You probably don't even think about this notation because it's so familiar.

Consider $$f(x, y)$$ from above; suppose I want to evaluate $$f(1, 2)$$. Then I have, in painstaking detail,

$$
\;{\small\begin{matrix}\\ \normalsize f \\ ^{\small \text{name}}\end{matrix} }\;
(
\;{\small\begin{matrix}\\ \normalsize 1 \\ ^{\small \text{input 1}}\end{matrix} }\;
,
\;{\small\begin{matrix}\\ \normalsize 2 \\ ^{\small \text{input 2}}\end{matrix} }\;
)
$$

Likewise, Racket has a **grammar** for calling a function. Consider `(+ 1 2)`:

$$
(
\;{\small\begin{matrix}\\ \normalsize \text{+} \\ ^{\small \text{name}}\end{matrix} }\;
\;{\small\begin{matrix}\\ \normalsize 1 \\ ^{\small \text{input 1}}\end{matrix} }\;
\enspace
\;{\small\begin{matrix}\\ \normalsize 2 \\ ^{\small \text{input 2}}\end{matrix} }\;
)
$$

Note two differences:

- Parens have been moved to surround the entire function call, *including* the function name, and
- Instead of commas to separate inputs, we use spaces.

We can now summarize the syntax rules for calling a function in Racket.

> 1. **Opening paren** `(` tells Racket *we are calling a function*;
> 2. **Function name**, e.g. `+`, tells Racket *which* function;
> 3. **Space** between function name and first input;
> 4. **Inputs in order, separated by spaces**;
> 5. **Closing paren** `)` tells Racket *we are done listing inputs*.

Now you should know how Racket evaluates `(+ 3 4 5)`, and why we need parens around the whole thing (because `+` is a function).

## Order of Operations

What happens we have more complex expressions, like `(+ (+ 1 2) 4 5)`?

In grade school, you probably learned about the order of operations (perhaps you had a catchy acronym like "PEMDAS"). Recall that mathematical operations are "ranked" in precedence as follows:

1. Parentheses,
2. Exponents,
3. Multiplication and division,
4. Addition and subtraction.

In addition to this hierarchy of operations, there are two other properties:

- If a set of operations are in the same "tier" (e.g. $$3 * 5 / 2 * 4$$), evaluation proceeds from *left to right*, and
- This hierarchy applies *recursively* within parenthetical expressions -- i.e. once we're inside the first set of parens, we apply the same rules again.

Racket's order of operations is even simpler than what you learned in grade school. In fact, it includes exactly one rule:

1. Parentheses.

Since every individual procedure call is wrapped in parentheses in Racket, we don't have to worry about operator precedence (e.g. multiplication before addition) beyond how deeply nested a procedure call is.

Above, we listed two auxiliary properties of mathematical order of operations. The same properties apply to Racket.

First, if a set of parenthetical expressions are nested at the same depth, we **evaluate them from left to right**. Consider the following example:

```scheme
(+ (* 2 4)
   (* 3 5))
```

Here, `(* 2 4)` and `(* 3 5)` are nested at the same level of depth, and we evaluate them from left to right -- first `(* 2 4)`, then `(* 3 5)`.

Second, order of operation rules apply *recursively* within parentheses -- the only difference is that in Racket, parentheses are the only ordering principle (as opposed to parentheses, then exponents, etc.)

In other words, **the deepest-nested expressions are simplified first**, followed by the next-deepest, and so on, until you reach the outermost level of nesting.

Consider the following example:

```scheme
(* (+ 1 1)
   3
   (+ 2
      (+ 4 5))
   7)
```

Expressions will be evaluated in the following order:

1. `(+ 4 5)`, the most deeply nested expression
2. `(+ 1 1)`, going from left to right at the second level of nesting
3. `(+ 2 9)`, going from left to right at the second level of nesting
   * Note that the `9` comes from evaluating `(+ 4 5)` in the first step
4. `(* 2 3 11 7)`, the outermost level of nesting
   * The `2` comes from evaluating `(+ 1 1)` in the second step
   * The `11` comes from evaluating `(+ 2 9)` in the third step

If this is still confusing, try running this example through the DrRacket stepper -- it is *much* easier to visualize there.

All in all, Racket evaluation can be simplified to the following two-part rule:

> **Evaluate parentheses first** (as deeply nested as necessary), then simplify your way out, working from **left to right** when multiple expressions are nested at the same level.

### Example: Designing a Mathematical Program

Let's apply what we know about program evaluation so far, and actually design a simple program ourselves.

As we've seen, Racket and math go hand in hand. In fact, mathematical expressions admit a straightforward representation in Racket code -- let's try that right now.

Recall the distance formula for two points, $$(x_1, y_1)$$ and $$(x_2, y_2)$$:
$$
\sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
$$

How do we write this in Racket?

First, we **identify the operations** we need, and their Racket equivalents:

- **Addition:** $$(a + b) \mapsto$$ `(+ a b)`
- **Subtraction:** $$(a - b) \mapsto$$ `(- a b)`
- **Square:** $$(a^2) \mapsto$$ `(sqr a)`
- **Square root:** $$(\sqrt{a}) \mapsto$$ `(sqrt a)`

Second, we think about the **order in which these operations need to be applied**.

1. First we **subtract**: $$(x_2 - x_1)$$ and $$(y_2 - y_1)$$,
2. Then we **square** those values,
3. Then we **add** the squared results together, and
4. Finally we **square root** the sum.

This gives us the **order in which we need to nest Racket expressions**, remembering that the outermost expression is called *last*. So we can gradually build our program up from the last step:

```scheme
; Finally we square root...
(sqrt number)

; ...the sum...
(sqrt (+ number
         number))

; ...of squared values...
(sqrt (+ (sqr number)
         (sqr number)))

; ...of subtracted values.
(sqrt (+ (sqr (- x2 x1))
         (sqr (- y2 y1))))
```

Notice how we use **placeholders** like `number` as we build our program up. Remember that all Racket programs are just nested, composed function calls, and each function call is a very simple sequence of "chunks." We can use placeholders if we're not 100% sure yet what the "chunks" should be.

As you gain more experience with Racket, you'll be able to write expressions like this in one go, without much thought. But in general, it's very helpful to use placeholders to **sketch the outline of your program**, then **plug in the actual expressions** when you've figured them out.

In the next section, we'll talk about Racket's **type system**, and see how we can design programs to transform other kinds of data, besides numbers.

## Common Pitfalls

In Racket, it's important to have exactly the right number of parens in your program. Here are some common gotchas encountered by new Racketeers:

### Forgetting the outermost parentheses

In math, since parentheses are mainly used to group expressions, we usually don't wrap the outermost level of an expression. We're more likely to just write
$$
1 + 2 + 3
$$

than
$$
(1 + 2 + 3).
$$

In Racket, parentheses matter because they denote the *start of a procedure call*. Racket looks for these parentheses to know when to actually evaluate a function, so if you leave them off, it just returns the same function:

```scheme
> + 1 2
+
1
2
```

Returning to the math analogy, `+ 1 2` without enclosing parentheses is the equivalent of saying,
$$
f(x, y), 1, 2.
$$

### Gratuitous parentheses

In algebra, you can add parentheses basically anywhere and it won't matter, so long as things are evaluated in the same order.

For instance, the expression $$2 + ((3 + 4))$$ is weird but valid.

In Racket, parens aren't just used for grouping -- as we've belabored, parens *tell the computer a function is about to be called*. Namely, when the computer sees `(`, it thinks that *whatever chunk comes next is the name of the function being called*.

So calling `(+ 2 ((+ 3 4)))` confuses the computer. It starts by evaluating the deepest-nested expression, which is `(+ 3 4)` in this case. Now we have

```scheme
(+ 2 (7))
```

and the computer sees the second `(` and thinks, "okay, the next *chunk* is going to be a function name." But the next *chunk* is `7`, which is *not* the name of a function (and even if it were, the function isn't given any inputs).

So you end up with an error like this:

```scheme
function call: expected a function after the open parenthesis, but received 7
```

and everyone is sad, especially you.
