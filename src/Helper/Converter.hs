module Helper.Converter where

import           Data.IntCast
import           GHC.Int

intToInt64 :: Int -> Int64
intToInt64 = intCast
