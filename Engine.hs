module Engine
( play
, score) where

import Data.List

data MaybeFrame = InvalidFrame | Frame { rolls :: [Int], frameScore :: Int, accumulated :: Int } deriving (Show, Read, Eq)
data Game = Game [MaybeFrame] deriving (Show, Read)

(strike, maxScore) = (10, 10)
indexForLast = 9
rollRange = [0..10]
startingIndex = 1
emptyAcc = 0
emptyGame = Game []
errorValue = -1

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


buildGame :: Int -> [Int] -> Game -> Game
buildGame _ [] (Game a)        = (Game a)
buildGame s xs (Game a)
    | length a == indexForLast = buildGame (getAccumulated lastFrame) [] (Game (a ++ [lastFrame]))
    | otherwise                = buildGame (getAccumulated newFrame) (drop (frameLength newFrame) xs) (Game (a ++ [newFrame]))
                                    where newFrame  = buildFrame xs s
                                          lastFrame = buildLastFrame xs s


buildFrame :: [Int] -> Int -> MaybeFrame
buildFrame (x:y:z:zs) acc
    | x == strike         = Frame { rolls = [x], frameScore = threeScore, accumulated = threeScore + acc }
    | (x + y) == maxScore = Frame { rolls = [x, y], frameScore = threeScore, accumulated = threeScore + acc }
    | (x + y) < 10        = Frame { rolls = [x, y], frameScore = twoScore, accumulated = twoScore + acc  }
                                where threeScore = x + y + z
                                      twoScore   = x + y
buildFrame _ _            = InvalidFrame


buildLastFrame :: [Int] -> Int -> MaybeFrame
buildLastFrame [x, y, z] acc
    | ((x == strike) || (x + y) == 10) = Frame { rolls = [x, y, z], frameScore = threeScore, accumulated = threeScore + acc }
                                            where threeScore = x + y + z
buildLastFrame [x, y] acc
    | x + y < 10                       = Frame { rolls = [x, y], frameScore = twoScore, accumulated = twoScore + acc  }
                                            where twoScore = x + y
buildLastFrame _ _                     = InvalidFrame


frameLength :: MaybeFrame -> Int
frameLength Frame { rolls = x } = length x
frameLength _                   = errorValue


validateInput :: [Int] -> Bool
validateInput [] = True
validateInput (x:xs)
    | elem x rollRange = validateInput xs
    | otherwise        = False


validateOutput :: Game -> Bool
validateOutput (Game []) = True
validateOutput (Game (x:xs))
    | x == InvalidFrame = False
    | otherwise         = validateOutput (Game xs)


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
showResult (Game []) _     = ""
showResult (Game (x:xs)) n = (showFrame x n) ++ (showResult (Game xs) (n+1))


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
getTotal (Game (x:[])) = getAccumulated x
getTotal (Game (x:xs)) = getTotal (Game xs)
getTotal _             = errorValue
