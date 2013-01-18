{-# LANGUAGE DeriveGeneric #-}

module Webb.Logic.Fact.Fact (
  (|=), nameOf, Fact, parseFact, dumpFact
) where

import Webb.Shared.Reference
import Webb.Logic.Abstract

import Data.Aeson

import Data.ByteString.Lazy (ByteString)

import GHC.Generics
-- A fact is a Name-Reference and a Value
data Fact a = FactImpl Reference a
 deriving (Eq, Show, Generic)

-- Assert a fact has a given truth value
(|=) :: AbstractLogic a => Reference -> a -> Fact a
(|=) = FactImpl

nameOf :: Fact a -> Reference
nameOf (FactImpl ref _) = ref

parseFact :: FromJSON a => ByteString -> Fact a
parseFact v = case eitherDecode v of
  Left msg  -> error msg
  Right ref -> ref

dumpFact  :: ToJSON a => Fact a -> ByteString
dumpFact = encode

-- Generics!
instance ToJSON a => ToJSON (Fact a) where
instance FromJSON a  => FromJSON (Fact a) where
