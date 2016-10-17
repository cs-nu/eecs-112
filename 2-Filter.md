# `filter`

The `filter` function allows us to **filter out elements of a list that don't match a given criteria**.

It takes two inputs:

1. A **predicate function**, i.e. a function that returns a boolean, and
2. A **list of elements** to filter according to the predicate.

It returns a subset of the original list, consisting of *only those elements for which the predicate returned `true`*.

```scheme
filter : (X -> boolean), (listof X) -> (listof X)
```

## Example

Suppose we have the following list of numbers:

```scheme
(list 1 2 4 5)
```

and we want to get all the odd numbers from this list. In other words, we want to *filter the list to keep the odd numbers*.

We know that the `odd?` predicate tells us whether a single number is odd. We can scale this function using `filter` on a list of numbers, to give us only the odd elements of the list.

```scheme
(filter odd? (list 1 2 4 5))
; (list 1 5)
```

| Item | Current Step | Result So Far |
|----|---|---|
| `1` | `(odd? 1) = true` | `(list 1)` |
| `2` | `(odd? 2) = false` | `(list 1)` |
| `4` | `(odd? 4) = false` | `(list 1)` |
| `5` | `(odd? 5) = true` | `(list 1 5)` |

[Here](./rkt/map-filter-examples.rkt) are more examples from recitation. This file is best viewed in DrRacket, but if you don't have it installed there is an online copy viewable [here](https://gist.github.com/sarahlim/418c4e57b8ae4e0a4494215e9e680a81).
