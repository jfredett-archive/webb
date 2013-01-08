module Main where

import Test.Framework (defaultMain, testGroup)

import qualified Webb.Logic.Fact.Tests
import qualified Webb.Shared.Tests

main :: IO ()
main = defaultMain tests
  where
   tests = [ testGroup "Webb.Logic.Fact"
             Webb.Logic.Fact.Tests.tests
           , testGroup "Webb.Shared"
             Webb.Shared.Tests.tests
           ]
