module Webb.Logic.Fact.Tests
  ( tests ) where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit hiding (Test)

tests :: [Test]
tests = [testExample]

testExample :: Test
testExample = testCase "example" $ 3*3 @?= 9
