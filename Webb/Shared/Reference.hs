module Webb.Shared.Reference (
  refer, Reference
) where

newtype Reference = Ref String
  deriving (Eq, Ord)

instance Show Reference where
  show (Ref s) = "[" ++ s ++ "]"

refer :: String -> Reference
refer = Ref

