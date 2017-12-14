Haskell Bowling
=================

An implementation in Haskell, as a first exercise in this language, of a program to validate and compute the score of a Ten-pin Bowling game.

A randomizer, that outputs an array with a random and correct score for a game, was further implemented. 

The implementation of the engine, responsible for validating, scoring, and outputing the result, is supported by 16 features tests - 10 valid inputs that are adequately scored, and 6 invalid inputs that are recognised as such.



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

'RandomBowling' will generate a random input and print its respective output. It receives a "balance" parameter (Int) that can be used to increase (>0) or decrease (<0) the expected random generated score (with 0 being neutral).


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


Sample Output
===================


```
~/repos/haskell/bowling/src > echo 5 | ./RandomBowling
Frame 1:
Rolls: 10
Frame Score: 20
Accumulated: 20

Frame 2:
Rolls: 3, 7
Frame Score: 10
Accumulated: 30

Frame 3:
Rolls: 0, 9
Frame Score: 9
Accumulated: 39

Frame 4:
Rolls: 10
Frame Score: 24
Accumulated: 63

Frame 5:
Rolls: 10
Frame Score: 20
Accumulated: 83

Frame 6:
Rolls: 4, 6
Frame Score: 20
Accumulated: 103

Frame 7:
Rolls: 10
Frame Score: 20
Accumulated: 123

Frame 8:
Rolls: 9, 1
Frame Score: 14
Accumulated: 137

Frame 9:
Rolls: 4, 6
Frame Score: 11
Accumulated: 148

Frame 10:
Rolls: 1, 9, 3
Frame Score: 13
Accumulated: 161

Total Score:
161

```
