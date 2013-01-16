module Webb.Logic.Fact.Fact (
  (|=), nameOf, Fact
) where

import Webb.Shared.Reference
import Webb.Logic.Abstract

import Data.Aeson
import Data.Aeson.Types
import Control.Applicative

-- A fact is a Name-Reference and a Value
data Fact a = FactImpl Reference a
 deriving (Eq, Show)

-- Assert a fact has a given truth value
(|=) :: AbstractLogic a => Reference -> a -> Fact a
(|=) = FactImpl

nameOf :: Fact a -> Reference
nameOf (FactImpl ref _) = ref
