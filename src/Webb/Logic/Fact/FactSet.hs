module Webb.Logic.Fact.FactSet(
    isKnownIn, isUnknownIn, empty, assumeFact, FactSet
) where

import Webb.Logic.Fact.Fact
import Webb.Shared.Reference

import qualified Data.Map as M

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
assumeFact f (FactSetImpl map) = FactSetImpl (M.insert (nameOf f) f map)

-- TODO Remaining: Parser to parse a list of facts (probably just JSON)
