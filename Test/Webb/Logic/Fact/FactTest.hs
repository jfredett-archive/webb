module Test.Webb.Logic.Fact.FactTest where

import Test.Framework
import Test.Framework.Providers.QuickCheck2
{-import Test.Framework.Providers.HUnit-}

import Test.QuickCheck
{-import Test.HUnit hiding (Test) -- We don't need/want this one.-}

import Webb.Logic.Fact.Fact

import Test.ArbitraryImpl

fact_tests :: Test
fact_tests = testGroup "Fact" [
              testProperty "A fact can be passed to and from JSON with no loss of information" prop_fact_json_id
            ]

-- this must be limited to a concrete Abstract Logic instance, we should test
-- with a few
prop_fact_json_id :: Fact Bool -> Property
prop_fact_json_id fact = property $ (parseFact . dumpFact $ fact) == fact
