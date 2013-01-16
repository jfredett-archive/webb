module Main where

import Data.Monoid
import Test.Framework

import Test.Webb.Shared.ReferenceTest

main :: IO ()
main = defaultMainWithOpts [ reference_tests ] mempty
