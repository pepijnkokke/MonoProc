module PROC
  ( module PROC.Base
  , module PROC.Parsing
  , module PROC.MF
  , ex1
  , ex2
  , ex3
  , ex4
  , ex5
  , mkProg
  ) where

import Prelude hiding (init)
import PROC.Base
import PROC.Parsing
import PROC.MF
import Text.ParserCombinators.UU.Utils (runParser)

parseProg  = runLabel . runParser "stdin" pProg
parseDecl  = runLabel . runParser "stdin" pDecl
parseStmt  = runLabel . runParser "stdin" pStmt

mkProg :: [String] -> Prog
mkProg = parseProg . unlines

ex1 = mkProg
  [ "x = 10;"
  , "if (x < 10) { y = 10; } else { y = 11; }"
  ]
ex2 = mkProg
  [ "const(x,y) {"
  ,   "return x;"
  , "}"
  , "x = 10;"
  , "y = 11;"
  , "z = const(x,y);"
  ]
ex3 = mkProg
  [ "a = 2;"
  , "b = 3 * a;"
  , "c = 5 * b;"
  , "b = b * c;"
  ]
ex4 = mkProg
  [ "x = 10;"
  , "while (x > 0) {"
  , "  x = x - 1;"
  , "  y = 10 * 10;"
  , "}"
  ]
ex5 = mkProg
  [ "a = 10;"
  , "b = a + 10;"
  , "c = b + 10;"
  , "d = c + 10;"
  ]
