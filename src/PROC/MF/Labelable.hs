module PROC.MF.Labelable where

import PROC.Base
import Control.Monad.Supply (Supply,supply,evalSupply)

class Labelable a where
  label :: a -> Supply Label a
  runLabel :: a -> a
  runLabel a = evalSupply (label a) [1..]
  
instance (Labelable a) => Labelable [a] where
  label = mapM label
  
instance Labelable Prog where
  label (Prog d s) = do d <- label d; s <- label s; return (Prog d s)
  
instance Labelable Decl where
  label (Decl n xs s)  = do s <- label s; return (Decl n xs s)
  
instance Labelable Stmt where
  label (Skip _)                 = do l <- supply; return (Skip l)
  label (Assign _ n ae)          = do l <- supply; return (Assign l n ae)
  label (IfThen (BExpr _ b) t f) = do l <- supply; t <- label t; f <- label f; return (IfThen (BExpr l b) t f)
  label (While (BExpr _ b) w)    = do l <- supply; w <- label w; return (While (BExpr l b) w)
  label (Call _ _ n as)          = do c <- supply; r <- supply; return (Call c r n as)
  label (Seq s1 s2)              = do s1 <- label s1; s2 <- label s2; return (Seq s1 s2)