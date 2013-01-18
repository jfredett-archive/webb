{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
module Webb.Shared.Reference (
  refer, safeRefer, Reference, parseReference, dumpReference, validReferenceName
) where

import Data.Aeson
import Control.Applicative
import Data.Maybe
import Data.ByteString.Lazy (ByteString)

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

parseReference :: ByteString -> Reference
parseReference v = case eitherDecode v of
  Left msg  -> error msg
  Right ref -> ref

dumpReference :: Reference -> ByteString
dumpReference = encode
