# Assignment 3: All about Fold (160 points)

## Due by Friday 2/19/21, 23:59:59

## Overview

The overall objective of this assignment is to expose you
to fold, *fold*, and more **fold**. And just when you think
you've had enough, **FOLD**.

The assignment is in the files:

1. [src/Hw3.hs](/src/Hw3.hs) has skeleton functions with
   missing bodies that you will fill in,
2. [tests/Test.hs](/tests/Test.hs) has some sample tests,
   and testing code that you will use to check your
   assignments before submitting.

You should only need to modify the parts of the files which say:

```haskell
error "TBD: ..."
```

with suitable Haskell implementations.

**Note:** Start early, to avoid any unexpected shocks late in the day.

## Assignment Testing and Evaluation

Your functions/programs **must** compile and run on `ieng6.ucsd.edu`.

Most of the points, will be awarded automatically, by
**evaluating your functions against a given test suite**.

[Tests.hs](/tests/Test.hs) contains a very small suite
of tests which gives you a flavor of of these tests.
When you run

```shell
$ make test
```

Your last lines should have

```
All N tests passed (...)
OVERALL SCORE = ... / ...
```

**or**

```
K out of N tests failed
OVERALL SCORE = ... / ...
```

**If your output does not have one of the above your code will receive a zero**

If for some problem, you cannot get the code to compile,
leave it as is with the `error ...` with your partial
solution enclosed below as a comment.

The other lines will give you a readout for each test.
You are encouraged to try to understand the testing code,
but you will not be graded on this.

## Submission Instructions

To submit your code, just do:

```bash
$ make turnin
```

## Problem 1: Warm-Up

### (a) 15 points

Fill in the skeleton given for `sqsum`,
which uses `foldl'` to get a function

```haskell
sqSum :: [Int] -> Int
```

such that `sqSum [x1,...,xn]` returns the integer `x1^2 + ... + xn^2`

Your task is to fill in the appropriate values for

1. the step function `f` and
2. the base case `base`.

Once you have implemented the function, you should get
the following behavior:

```haskell
ghci> sqSum []
0

ghci> sqSum [1, 2, 3, 4]
30

ghci> sqSum [(-1), (-2), (-3), (-4)]
30
```

### (b) 30 points

Fill in the skeleton given for `pipe` which uses `foldl'`
to get a function

```haskell
pipe :: [(a -> a)] -> (a -> a)
```

such that `pipe [f1,...,fn] x` (where `f1,...,fn` are functions!)
should return `f1(f2(...(fn x)))`.

Again, your task is to fill in the appropriate values for

1. the step function `f` and
2. the base case `base`.

Once you have implemented the function, you should get
the following behavior:

```haskell
ghci> pipe [] 3
3

ghci> pipe [(\x -> x+x), (\x -> x + 3)] 3
12

ghci> pipe [(\x -> x * 4), (\x -> x + x)] 3
24
```


### (c) 20 points

Fill in the skeleton given for `sepConcat`,
which uses `foldl'` to get a function

```haskell
sepConcat :: String -> [String] -> String
```

Intuitively, the call `sepConcat sep [s1,...,sn]` where

* `sep` is a string to be used as a separator, and
* `[s1,...,sn]` is a list of strings

should behave as follows:


* `sepConcat sep []` should return the empty string `""`,
* `sepConcat sep [s]` should return just the string `s`,
* otherwise (if there is more than one string) the output
  should be the string `s1 ++ sep ++ s2 ++ ... ++ sep ++ sn`.

You should only modify the parts of the skeleton consisting
of `error "TBD" "`. You will need to define the function `f`,
and give values for `base` and `l`.

Once done, you should get the following behavior:

```haskell
ghci> sepConcat ", " ["foo", "bar", "baz"]
"foo, bar, baz"

ghci> sepConcat "---" []
""

ghci> sepConcat "" ["a", "b", "c", "d", "e"]
"abcde"

ghci> sepConcat "X" ["hello"]
"hello"
```

### (d) 10 points

Implement the function

```haskell
stringOfList :: (a -> String) -> [a] -> String
```

such that `stringOfList f [x1,...,xn]` should return the string
`"[" ++ (f x1) ++ ", " ++ ... ++ (f xn) ++ "]"`

This function can be implemented on one line,
**without using any recursion** by calling
`map` and `sepConcat` with appropriate inputs.

You should get the following behavior:

```haskell
ghci> stringOfList show [1, 2, 3, 4, 5, 6]
"[1, 2, 3, 4, 5, 6]"

ghci> stringOfList (\x -> x) ["foo"]
"[foo]"

ghci> stringOfList (stringOfList show) [[1, 2, 3], [4, 5], [6], []]
"[[1, 2, 3], [4, 5], [6], []]"
```

## Problem 2: Big Numbers

The Haskell type `Int` only contains values up to a certain size (for reasons
that will become clear as we implement our own compiler). For example,

```haskell
ghci> let x = 99999999999999999999999999999999999999999999999 :: Int

<interactive>:3:9: Warning:
    Literal 99999999999999999999999999999999999999999999999 is out of the Int range -9223372036854775808..9223372036854775807
```

You will now implement functions to manipulate arbitrarily large
numbers represented as `[Int]`, i.e. lists of `Int`.

### (a) 10 + 5 + 10 points

Write a function

```haskell
clone :: a -> Int -> [a]
```

such that `clone x n` returns a list of `n` copies of the value `x`.
If the integer `n` is `0` or negative, then `clone` should return
the empty list. You should get the following behavior:

```haskell
ghci> clone 3 5
[3, 3, 3, 3, 3]

ghci> clone "foo" 2
["foo", "foo"]
```

Use `clone` to write a function

```haskell
padZero :: [Int] -> [Int] -> ([Int], [Int])
```

which takes two lists: `[x1,...,xn]` `[y1,...,ym]` and
adds zeros in front of the _shorter_ list to make the
list lengths equal.

Your implementation should **not** be recursive.

You should get the following behavior:

```haskell
ghci> padZero [9, 9] [1, 0, 0, 2]
([0, 0, 9, 9], [1, 0, 0, 2])

ghci> padZero [1, 0, 0, 2] [9, 9]
([1, 0, 0, 2], [0, 0, 9, 9])
```

Next, write a function

```haskell
removeZero :: [Int] -> [Int]
```

that takes a list and removes a prefix of leading zeros, yielding
the following behavior:

```haskell
ghci> removeZero [0, 0, 0, 1, 0, 0, 2]
[1, 0, 0, 2]

ghci> removeZero [9, 9]
[9, 9]

ghci> removeZero [0, 0, 0, 0]
[]
```

### (b) 25 points

Let us use the list `[d1, d2, ..., dn]`, where each `di`
is between `0` and `9`, to represent the (positive)
**big-integer** `d1d2...dn`.

```haskell
type BigInt = [Int]
```

For example, `[9, 9, 9, 9, 9, 9, 9, 9, 9, 8]` represents
the big-integer `9999999998`. Fill out the implementation for

```haskell
bigAdd :: BigInt -> BigInt -> BigInt
```

so that it takes two integer lists, where each integer is
between `0` and `9` and returns the list corresponding to
the addition of the two big-integers. Again, you have to
fill in the implementation to supply the appropriate values
to `f`, `base`, `args`. You should get the following behavior:

```haskell
ghci> bigAdd [9, 9] [1, 0, 0, 2]
[1, 1, 0, 1]

ghci> bigAdd [9, 9, 9, 9] [9, 9, 9]
[1, 0, 9, 9, 8]
```

### (c) 15 + 20 points

Next you will write functions to multiply two big integers.
First write a function

```haskell
mulByDigit :: Int -> BigInt -> BigInt
```

which takes an integer digit and a big integer, and returns the
big integer list which is the result of multiplying the big
integer with the digit. You should get the following behavior:

```haskell
ghci> mulByDigit 9 [9,9,9,9]
[8,9,9,9,1]
```

Now, using `mulByDigit`, fill in the implementation of

```haskell
bigMul :: BigInt -> BigInt -> BigInt
```

Again, you have to fill in implementations for `f` , `base` , `args` only.
Once you are done, you should get the following behavior at the prompt:

```haskell
ghci> bigMul [9,9,9,9] [9,9,9,9]
[9,9,9,8,0,0,0,1]

ghci> bigMul [9,9,9,9,9] [9,9,9,9,9]
[9,9,9,9,8,0,0,0,0,1]
```
