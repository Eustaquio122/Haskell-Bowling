module Engine
( play
, score) where

import Data.List


-- TYPES --
data MaybeFrame = InvalidFrame | Frame { rolls :: [Int], frameScore :: Int, accumulated :: Int } deriving (Show, Read, Eq)
type Game = [MaybeFrame]


-- FIXED VALUES --
(strike, maxScore) = (10, 10)
indexForLast       = 9
startingIndex      = 1
emptyAcc           = 0
errorValue         = -1
rollRange          = [0..10]
emptyGame          = []


-- EXTERNAL --
play :: [Int] -> String
play xs
    | not (validateInput xs)    = "Invalid Input\n"
    | not (validateOutput game) = "Processing Error\n"
    | otherwise                 = showResult game startingIndex
        where game = buildGame emptyAcc xs emptyGame

score :: [Int] -> Int
score xs
    | not (validateInput xs)    = errorValue
    | not (validateOutput game) = errorValue
    | otherwise                 = totalScore
        where game       = buildGame emptyAcc xs emptyGame
              totalScore = getTotal game


-- MAIN LOGIC --
buildGame :: Int -> [Int] -> Game -> Game
buildGame _ [] a        = a
buildGame s xs a
    | length a == indexForLast = buildGame (getAccumulated lastFrame) [] (a ++ [lastFrame])
    | otherwise = buildGame (getAccumulated newFrame) (removeRolls newFrame xs) (a ++ [newFrame])
        where newFrame  = buildFrame xs s
              lastFrame = buildLastFrame xs s

buildFrame :: [Int] -> Int -> MaybeFrame
buildFrame (x:y:z:zs) acc
    | x == strike         = newFrame [x] threeScore acc
    | (x + y) == maxScore = newFrame [x, y] threeScore acc
    | (x + y) < 10        = newFrame [x, y] twoScore acc
        where threeScore = x + y + z
              twoScore   = x + y
buildFrame _ _            = InvalidFrame

buildLastFrame :: [Int] -> Int -> MaybeFrame
buildLastFrame [x, y, z] acc
    | ((x == strike) || (x + y) == 10) = newFrame [x, y, z] threeScore acc
        where threeScore = x + y + z
buildLastFrame [x, y] acc
    | x + y < 10 = newFrame [x, y] twoScore acc
        where twoScore = x + y
buildLastFrame _ _ = InvalidFrame


-- HELPERS --
newFrame :: [Int] -> Int -> Int -> MaybeFrame
newFrame rolls score acc = Frame { rolls = rolls, frameScore = score, accumulated = score + acc }

removeRolls :: MaybeFrame -> [Int] -> [Int]
removeRolls (Frame a b c) gameArray = drop (length a) gameArray
removeRolls _ _                     = []

validateInput :: [Int] -> Bool
validateInput [] = True
validateInput (x:xs)
    | elem x rollRange = validateInput xs
    | otherwise        = False

validateOutput :: Game -> Bool
validateOutput [] = True
validateOutput (x:xs)
    | x == InvalidFrame = False
    | otherwise         = validateOutput xs

getRolls :: MaybeFrame -> [Int]
getRolls InvalidFrame        = [errorValue]
getRolls Frame { rolls = r } = r

getScore :: MaybeFrame -> Int
getScore InvalidFrame             = errorValue
getScore Frame { frameScore = s } = s

getAccumulated :: MaybeFrame -> Int
getAccumulated InvalidFrame              = errorValue
getAccumulated Frame { accumulated = a } = a

showResult :: Game -> Int -> String
showResult [] _     = ""
showResult (x:xs) n = (showFrame x n) ++ showResult xs (n+1)

showFrame :: MaybeFrame -> Int -> String
showFrame x n = showTitle n ++ showRolls x ++ showScore x ++ showAccumulated x

showTitle :: Int -> String
showTitle n = "Frame " ++ show n ++ ":\n"

showRolls :: MaybeFrame -> String
showRolls x = "Rolls: " ++ intercalate ", " (map show (getRolls x)) ++ "\n"

showScore :: MaybeFrame -> String
showScore x = "Frame Score: " ++ show (getScore x) ++ "\n"

showAccumulated :: MaybeFrame -> String
showAccumulated x = "Accumulated: " ++ show (getAccumulated x) ++ "\n\n"

getTotal :: Game -> Int
getTotal (x:[]) = getAccumulated x
getTotal (x:xs) = getTotal xs
getTotal _      = errorValue
