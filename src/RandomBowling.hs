import Engine
import Randomizer
import Data.Char
-- import System.IO

main = do
    balance <- getLine
    let newGame = randomGame $ read balance
    putStr $ play newGame
    putStr "Total Score:\n"
    putStr . show $ score newGame
    putStr "\n\n"
