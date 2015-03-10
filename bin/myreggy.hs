-- | Authour: Dante Elrik
module Main where

type ParseResult    = ReadS (String)

data Regex   = Regex {
 expression :: String
 }

type Greedy=  Bool
data Rg = Literal [Char]
        | NumericRange Int Int
        | CharRange Char Char
        | WildCard Greedy
          deriving Show

instance Show Regex where
  show l = "/" ++ (expression l) ++ "/"

mkRegex   :: String -> Regex
mkRegex   = Regex

tRegex    = mkRegex "abc"
tRegex2   = mkRegex "abc[456]123"
tRegex3   = mkRegex "abc.23"
tRegex4   = mkRegex "[0123456789][0123456789].[0123456789][0123456789].[0123456789][0123456789]"

evalRegex     :: Regex -> ParseResult
evalRegex r s = go (expression r) s ""
  where
    go [] remaining matches              = return (matches, remaining)
    go ms remaining@[] matches           = return (matches, remaining)
    go ('[':ms) (t:ts) matches           = case t `elem` (takeWhile (/= ']') ms) of
                                            True  -> go (dropWhile (/=']') ms) ts (matches ++ [t])
                                            False -> go (expression r) ts ""
    go (']':ms) ts matches = go ms ts matches
    go (m:ms) (t:ts) matches
      | m == '.'  = go ms ts (matches ++ [t])
      | m == t    = go ms ts (matches ++ [t])
      | otherwise = go (expression r) ts ""

main = do
  pattern    <- getLine
  input      <- getLine
  let
    expression = mkRegex pattern
    [(matched,unparsed)] = evalRegex expression input
  print $ matched ++ "," ++ unparsed
