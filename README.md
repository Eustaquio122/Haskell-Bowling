Haskell Bowling
=================

An implementation in Haskell, as a first exercise in this language, of a program to validate and compute the score of a Ten-pin Bowling game.

A randomizer, that outputs an array with a random and correct score for a game, was further implemented. 

The implementation of the engine, responsible for validanting, scoring, and outputing the result, is supported by 16 features tests - 10 valid inputs that are adequately score, and 6 invalid inputs that are recognised as such.


Using the Program
===================

Clone this repository.

You can use this program in two ways.
Examples on how to use it, using GHC:

Bowling:
----------

'Bowling' will read a fixed input (Perfect Game) from input.txt and print an output with a frame by frame description of the score, finishing with the total score.

Go to src and run:

```
> ghc --make Bowling
> ./Bowling
```

Random Bowling:
-----------------

'RandomBowling' will generate a random input and print its respective output. It receives a "balance" parameter (Int >= 0) that can be used to increase the expected random generated score.


Go to src and run:

```
> ghc --make RandomBowling
```

Then, either:
```
> ./RandomBowling
```
and enter the balance

Or:
```
> echo [balance] | ./RandomBowling
```
