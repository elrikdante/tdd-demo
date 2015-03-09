-- |
module Main where

type ParseResult    = ReadS (String)

data Regex   = Regex {
 expression :: String
 }

instance Show Regex where
  show l = "/" ++ (expression l) ++ "/"

evalRegex     :: Regex -> ParseResult
evalRegex r s = go (expression r) s ""
  where
    go  _ [] matches        = return (matches,"")
    go [] remaining matches = return (matches, remaining)
    go (m:ms) (t:ts) matches
      | t == m    = go ms ts (matches ++ [t])
      | otherwise = go (expression r) ts []


mkRegex   :: String -> Regex
mkRegex   = Regex

tRegex    = Regex "abc"
tRegex2   = Regex "danterocks"

main = do
       pattern    <- getLine
       input      <- getLine
       let
         expression = mkRegex pattern
         result@[(matched,unparsed)] = evalRegex expression input
       print result
