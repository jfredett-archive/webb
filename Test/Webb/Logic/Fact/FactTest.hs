module Test.Webb.Logic.Fact.FactTest where

import Control.Applicative

import Test.Framework
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.HUnit

import Test.QuickCheck
import Test.HUnit hiding (Test) -- We don't need/want this one.

import Webb.Logic.Fact.Fact


fact_tests :: Test
fact_tests = testGroup "Fact" []
