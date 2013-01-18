{-# LANGUAGE NoMonomorphismRestriction #-}
module Test.Webb.Shared.ReferenceTest where

import Test.Framework
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.HUnit

import Test.QuickCheck
import Test.HUnit hiding (Test) -- We don't need/want this one.

import Webb.Shared.Reference

import Test.ArbitraryImpl

reference_tests :: Test
reference_tests = testGroup "Reference" [
                    testProperty "A reference can be passed to and from JSON with no loss of information" prop_reference_json_id,
                    testCase "A reference cannot be named the empty string" case_reference_empty_string,
                    testProperty "A reference cannot be named with a string containing spaces" prop_reference_spaces_invalid,
                    testProperty "A reference cannot be named with a string containing other illegal characters" prop_reference_invalid_chars
                  ]


prop_reference_json_id :: Reference -> Property
prop_reference_json_id ref = property $ (parseReference . dumpReference $ ref) == ref


case_reference_empty_string :: Assertion
case_reference_empty_string = case safeRefer "" of
                                Just _ -> assertFailure "Was able to create a Reference from the empty String"
                                _      -> return ()

prop_reference_invalid_chars :: String -> Property
prop_reference_invalid_chars string = any (\x -> x `elem` string) "\\/ !@#$%^&*()=`~\"'"
                                  ==> case safeRefer string of
                                      Just _ -> False
                                      _      -> True

prop_reference_spaces_invalid :: String -> Property
prop_reference_spaces_invalid string = (not $ ' ' `elem` string)
                                   ==> case safeRefer "" of
                                     Just _ -> False
                                     _      -> True
