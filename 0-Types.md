# Types

Although most of the code we've seen involves numbers, Racket is a programming language for working with all kinds of data (otherwise it would just be a glorified calculator).

Computer scientists refer to different forms of data as different **types**.

Here are some of the basic types in Racket, along with examples of function usage for each.

### Numbers

Numbers are regular old numbers. They can be positive or negative, rational or irrational. In this course, you'll generally be working with the integers.

- `10`
- `-10`
- `(sqrt 2)`

```scheme
; `max` returns the largest of a sequence of numbers
> (max 1 -5 99)
99

; `round` rounds a number down to the nearest integer
> (round 12.3)
12.0
```

### Strings

Strings are text, surrounded by double quotation marks `""`.

- `"hello"`
- `"How are you doing?"`
- `"4482"`
    + Why is this not a number? Because it has double quotes.
- `"\"You only live once!\" he screamed into the void."`
    + Since double quotes delimit the beginning and end of a string, if we want to include actual double quotes inside our strings, we need to **escape*- them with a backslash (`\`)

```scheme
; `string-append` concatenates strings together
> (string-append "hello" "it's" "me")
"helloit'sme"
```

### Booleans

Booleans (BOO-lee-uns) are logical values.

- `true`
- `false`
- that's it there are no more

```scheme
; `and` returns `true` if and only if both arguments are `true`
> (and true true)
true

; `or` returns `true` if and only if at least one argument is `true`
> (or true false)
true

; `not` returns the logical opposite of its argument
> (not true)
false
```

### Images

Images are images, just like you're used to. You can generate images in DrRacket using the `2htdp/image` teachpack, and you can bring in outside images, too.

- `(circle 50 "solid" "red")`
- ![picture of Rick Astley](http://66.media.tumblr.com/avatar_369b115beb6e_128.png)
    + If you haven't yet tried copy-pasting images into DrRacket for your programs, I'm sorry for your loss?

```scheme
; we need to import the image library first
(require 2htdp/image)

> (overlay (circle 10 "solid" "red") (circle 20 "solid" "blue"))
```
![red circle overlaid on blue circle](https://cloudup.com/c5LGdRMHDuU+)

```scheme
> (rotate 45 (ellipse 60 20 "solid" "green"))
```
![green ellipse rotated 45 degrees](https://cloudup.com/cuyXSaNR_C1+)

## Defining Constants

We can define **constants** to simplify our programs. Constants are like variables, except their values can't be changed in the middle of a program.

The syntax for defining a constant is:

```scheme
(define constant-name constant-value)
```

where `constant-name` is usually capitalized, by convention, and `nstant-value` is any expression or literal data type we've already seen.

```scheme
(require 2htdp/image)

(define WIDTH 30)
(define HEIGHT (+ 9 1))
(define LAST-NAME "Lim")
(define BLOB (circle 50 "solid" "red"))

> (+ HEIGHT WIDTH)
40
> (string-append "My last name is " LAST-NAME)
"My last name is Lim"
> (overlay BLOB (rectangle 100 200 "solid" "gray"))
```
![red circle on a gray rectangle](https://cloudup.com/czBgQ8wBvgL+)
