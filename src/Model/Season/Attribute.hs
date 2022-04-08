{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}

module Model.Season.Attribute where

import           ClassyPrelude.Yesod

import           Class.ToPersistKey

import           Database.Persist.Sql

import           Helper.TypeConverter

-- Season Attributes
newtype SeasonId =
    SeasonId Int
    deriving (Show, Read, Eq, PathPiece, FromJSON)

instance ToPersistKey SeasonId where
    toKey (SeasonId x) =  toSqlKey . intToInt64 $ x

instance ToJSON SeasonId where
    toJSON (SeasonId x) = toJSON x

newtype SeasonNo =
    SeasonNo Int
    deriving (Show, Eq, FromJSON)

instance ToJSON SeasonNo where
    toJSON (SeasonNo x) = toJSON x

newtype Year =
    Year Int
    deriving (Show, Eq, FromJSON)

instance ToJSON Year where
    toJSON (Year x) = toJSON x
