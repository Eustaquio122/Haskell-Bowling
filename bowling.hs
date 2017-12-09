import Engine
import System.IO
import Data.Char
import Data.List.Split

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

makeInt :: [String] -> [Int]
makeInt = map read

main = do
    contents <- readLines "input.txt"
    let input = makeInt contents
    putStr (play input) 
    putStr (show (score input))




-- "10 10 10 10 10 10 10 10 10 10 10 10\n"