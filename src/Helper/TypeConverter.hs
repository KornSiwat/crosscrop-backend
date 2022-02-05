module Helper.TypeConverter where

import           Data.IntCast
import           Data.Text
import           Data.Time
import           GHC.Int
import           Text.Read

intToInt64 :: Int -> Int64
intToInt64 = intCast

parseUTCTime :: Text -> Maybe UTCTime
parseUTCTime x = readMaybe . unpack $ x :: Maybe UTCTime
