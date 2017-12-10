module Randomizer (randomGame) where

import System.Random
import System.IO.Unsafe


(strike, maxScore) = (10, 10)
indexForLast       = 9
startingIndex      = 0
errorValue         = -1
emptyInput         = []

randomGame :: Int -> [Int]
randomGame balance = generateInput balance startingIndex emptyInput

generateInput :: Int -> Int -> [Int] -> [Int]
generateInput b n xs
    | n == indexForLast    = xs ++ (generateLastFrame b [])
    | n > indexForLast     = [errorValue] 
    | otherwise            = generateInput b (n + 1) (xs ++ (generateFrame b []))

generateFrame :: Int -> [Int] -> [Int]
generateFrame b []         = generateFrame b [randomRoll b maxScore]
generateFrame b xs 
        | roll == strike = xs
        | otherwise      = xs ++ [randomRoll b (maxScore - roll)]
            where roll = head xs

generateLastFrame :: Int -> [Int] -> [Int]
generateLastFrame b []   = generateLastFrame b [randomRoll b maxScore]
generateLastFrame b (x:[])
    | x == strike      = generateLastFrame b (x:[randomRoll b maxScore])
    | otherwise        = generateLastFrame b (x:[randomRoll b (maxScore - x)])
generateLastFrame b [x, y]
    | x + y < maxScore = [x, y]
    | otherwise        = [x, y] ++ [randomRoll b maxScore]

randomRoll :: Int -> Int -> Int
randomRoll b x
    | base + balance > x = x
    | otherwise          = base + balance
    where base = unsafePerformIO (randomRIO (0, x))
          balance = unsafePerformIO (randomRIO (0, b))

