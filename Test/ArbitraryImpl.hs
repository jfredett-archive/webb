module Test.ArbitraryImpl where

import Control.Applicative

import Test.QuickCheck

import Webb.Shared.Reference
import Webb.Logic.Fact.Fact
import Webb.Logic.Abstract

instance Arbitrary Reference where
  arbitrary = refer <$> arbitrary `suchThat` validReferenceName

instance (Arbitrary a, AbstractLogic a) => Arbitrary (Fact a) where
  arbitrary = do
    x <- arbitrary
    y <- arbitrary
    return $ x |= y
