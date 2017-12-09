import Engine
import System.IO
import Data.Char


readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

makeInt :: [String] -> [Int]
makeInt = map read

main = do
    contents <- readLines "input.txt"
    let input = makeInt contents
    putStr $ play input
    putStr "Total Score:\n"
    putStr . show $ score input
    putStr "\n\n"
