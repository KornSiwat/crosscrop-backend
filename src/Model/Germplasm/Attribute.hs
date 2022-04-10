{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}

module Model.Germplasm.Attribute where

import           ClassyPrelude.Yesod

import           Class.ToPersistKey

import           Database.Persist.Sql

import           Helper.TypeConverter

-- Basic Attributes
newtype GermplasmId =
    GermplasmId Int
    deriving (Show, Read, Eq, PathPiece, FromJSON)

instance ToPersistKey GermplasmId where
    toKey (GermplasmId x) =  toSqlKey . intToInt64 $ x

instance ToJSON GermplasmId where
    toJSON (GermplasmId x) = toJSON x

newtype GermplasmName
    = GermplasmName Text
    deriving (Show, Eq, FromJSON)

instance ToJSON GermplasmName where
    toJSON (GermplasmName x) = toJSON x
