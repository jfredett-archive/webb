module Webb.Logic.Fact (
  (|=), isKnownIn, isUnknownIn, empty, assumeFact, Fact, FactSet
) where
import qualified Data.Map as M

import Webb.Shared.Reference
import Webb.Logic.Abstract

-- A fact is a Name-Reference and a Value
data Fact a = FactImpl Reference a
 deriving (Eq, Show)

-- Assert a fact has a given truth value
(|=) :: AbstractLogic a => Reference -> a -> Fact a
(|=) = FactImpl

-- A FactSet is a set of facts indexed by name, we need to provide a slightly
-- altered API over FactSet, so we'll wrap in a newtype and alias appropriately
newtype FactSet a = FactSetImpl (M.Map Reference (Fact a))

-- isKnownIn determines whether a given fact is within the factset, regardless of
-- it's truth value
isKnownIn :: Reference -> FactSet a -> Bool
isKnownIn ref (FactSetImpl map) = M.member ref map

-- the opposite of isKnownIn
isUnknownIn :: Reference -> FactSet a -> Bool
isUnknownIn x y = not $ isKnownIn x y

-- generate an empty factset
empty :: FactSet a
empty = FactSetImpl M.empty

-- assume a fact into evidence, if the fact is known, update it to reflect the
-- (potentially) new truth value
assumeFact :: Fact a -> FactSet a -> FactSet a
-- pretty sure this is fmap/lift M.insert
assumeFact f@(FactImpl ref _) (FactSetImpl map) = FactSetImpl (M.insert ref f map)

