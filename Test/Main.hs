module Main where

import Data.Monoid
import Test.Framework

import Test.Webb.Shared.ReferenceTest
import Test.Webb.Logic.Fact.FactTest

main :: IO ()
main = defaultMainWithOpts [ reference_tests
                           , fact_tests ]
                           mempty
