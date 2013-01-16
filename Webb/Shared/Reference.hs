{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
module Webb.Shared.Reference (
  refer, safeRefer, Reference, parseReference, dumpReference, validReferenceName
) where

import Data.Aeson
{-import Data.Aeson.Types-}
import Control.Applicative
import Data.Maybe

newtype Reference = Ref String
  deriving (Eq, Ord)

instance Show Reference where
  show (Ref s) = "[" ++ s ++ "]"

safeRefer :: String -> Maybe Reference
safeRefer string
  | validReferenceName string = Just . Ref $ string
  | otherwise                 = Nothing

noInvalidCharsIn :: String -> Bool
noInvalidCharsIn s = not $ any (\x -> x `elem` s) invalidReferenceCharacters

invalidReferenceCharacters :: [Char]
invalidReferenceCharacters = "\\/ !@#$%^&*()=`~\"\'"

validReferenceName :: String -> Bool
validReferenceName s = (noInvalidCharsIn s)
                    && (s /= "")
                    && (not $ ' ' `elem` s)


refer :: String -> Reference
refer = fromJust . safeRefer

instance ToJSON Reference where
  toJSON (Ref s) = object $ ["ref" .= s]

instance FromJSON Reference where
  parseJSON (Object v) = Ref <$> v .: "ref"
  parseJSON _ = empty

parseReference :: Value -> Reference
parseReference v = case fromJSON v of
  Error msg   -> error msg
  Success ref -> ref

dumpReference :: Reference -> Value
dumpReference = toJSON
