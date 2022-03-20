module Helper.TypeConverter where

import           Data.Text
import           Data.Time

import           Error.Definition

import           GHC.Int

import           Text.Read

intToInt64 :: Int -> Int64
intToInt64 = fromIntegral

int64ToInt :: Int64 -> Int
int64ToInt = fromIntegral

parseUTCTime :: Text -> Maybe UTCTime
parseUTCTime x = readMaybe . unpack $ x :: Maybe UTCTime

maybeToEither :: Error -> Maybe a -> Either Error a
maybeToEither e Nothing  = Left e
maybeToEither _ (Just x) = Right x

