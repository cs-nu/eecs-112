# Structs and Lists

Thus far, we've only worked with simple data objects, such as strings or numbers. What if we want to express more complex data?

## Structs

A **struct** is like a "template" for a particular kind of data. We can define a new template using `define-struct`:

```scheme
(define-struct <StructName> (<Field1> <Field2> ... <FieldN>))
```

So `define-struct` takes two "chunks":

1. A **name** for the template/struct, and
2. A parenthetical sequence of **fields**.

```scheme
; Defines a new template for a `person`
; - last-name is a string
; - first-name is a string
; - age is a number
(define-struct person (last-name first-name age))
```

When we define a new struct template, we get three new kinds of functions:

1. `make-<StructName>` allows us to generate new *instances* of the struct by filling in the template fields
2. `<StructName>?` allows us to check whether some object is an instance of the struct
3. `<StructName>-<Field>` allows us to "reach into" an instance of the struct, and extract the value for a particular field

Let's take a closer look at each of these.

### Making new instances

```scheme
(make-<StructName> <Field1Value> <Field2Value> ... <FieldNValue>)
```

For example:

```scheme
(define-struct person (last-name first-name age))

(make-person "Lim" "Sarah" 20)
(make-person "Horswill" "Ian" 99)

; We can define new constants, too
(define SLIM (make-person "Lim" "Sarah" 20))
```

### Checking whether something is an instance

```scheme
(<StructName>? <object>)
```

Continuing the above example (i.e. assuming we've already called `define-struct`, `make-person`, etc.)

```scheme
(person? (make-person "Horswill" "Ian" 99))  ; true
(person? "hello")  ; false

(define SLIM (make-person "Lim" "Sarah" 20))
(person? SLIM)  ; true
```

### Accessing fields

```scheme
(<StructName>-<Field> <struct>)
```

Recalling our definition of the `person` struct:

```scheme
(define-struct person (last-name first-name age))

(person-age (make-person "Horswill" "Ian" 99))  ; 99

(define SLIM (make-person "Lim" "Sarah" 20))
(person-age SLIM)  ; 20

(person-age "hello")  ; ERROR: person-age: expects a person, given "hello"
```

## Lists

Lists are ordered sequences of data.

```scheme
(list <Item1> <Item2> ... <ItemN>)
```

Here are some examples.

```scheme
; (listof number)
(list 1 2 -40 0.5)

; (listof string)
(list "jet" "fuel" "can't" "melt" "steel" "beams")

; (listof boolean, number)
(list true 4 false false 99 0.3 true)

; (listof person)
(list (make-person "Horswill" "Ian" 99)
      (make-person "Lim" "Sarah" 20))
```

You can use the `length` function to get the number of items in any list.

```scheme
(length (list 1 2 -40 0.5))  ; 4

(define LIST_OF_STRINGS
  (list "jet" "fuel" "can't" "melt" "steel" "beams"))

(length LIST_OF_STRINGS)  ; 6

(define LIST_OF_PEOPLE
  (list (make-person "Horswill" "Ian" 99)
        (make-person "Lim" "Sarah" 20)))

(length LIST_OF_PEOPLE)  ; 2
```
