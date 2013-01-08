module Webb.Shared.Tests
  ( tests ) where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2
import Test.QuickCheck hiding ((><))
import Test.HUnit hiding (Test)

tests :: [Test]
tests = [
          testExample2
        , prop_reverseReverse
        ]

testExample2 :: Test
testExample2 = testCase "example" $ 3*4 @?= 12

prop_reverseReverse :: Test
prop_reverseReverse = testProperty "Reverse of reverse is reverse" prop
  where prop xs = xs  == reverse (reverse (xs :: String))
