-- | Authour: Dante Elrik
module Main where

type ParseResult    = ReadS (String)

data Regex   = Regex {
 expression :: String
 }

instance Show Regex where
  show l = "/" ++ (expression l) ++ "/"

mkRegex   :: String -> Regex
mkRegex   = Regex

tRegex    = Regex "abc"
tRegex2   = Regex "abc[456]123"
tRegex3   = Regex "abc.23"
tRegex4   = Regex "[0123456789][0123456789].[0123456789][0123456789].[0123456789][0123456789]"

main = do
       pattern    <- getLine
       input      <- getLine
       let
         expression = mkRegex pattern
         result@[(matched,unparsed)] = evalRegex expression input
       print $ matched ++ "," ++ unparsed



evalRegex     :: Regex -> ParseResult
evalRegex r s = go (expression r) s ""
  where
    go [] remaining matches              = return (matches, remaining)
    go ms [] matches                     = return (matches, [])
    go charClass@('[':ms) (t:ts) matches = case t `elem` (takeWhile (/= ']') ms) of
                                  True  -> go (dropWhile (/=']') ms) ts (matches ++ [t])
                                  False -> go (expression r) ts ""
    go (']':ms) ts matches = go ms ts matches
    go (m:ms) (t:ts) matches
      | m == '.'  = go ms ts (matches ++ [t])
      | m == t    = go ms ts (matches ++ [t])
      | otherwise = go (expression r) ts ""
