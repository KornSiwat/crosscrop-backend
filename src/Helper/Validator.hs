module Helper.Validator where

import           Data.Functor.Contravariant (Predicate (Predicate, getPredicate))

isValid :: [a -> Bool] -> a -> Bool
isValid = getPredicate . foldMap Predicate
