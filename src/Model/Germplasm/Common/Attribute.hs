{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}

module Model.Germplasm.Common.Attribute where

import           ClassyPrelude.Yesod

import           Class.ToJSONKeyText
import           Class.ToPersistKey
import           Class.ToValue

import           Data.Aeson           as A
import           Data.Scientific

import           Database.Persist.Sql

import           Helper.TypeConverter

-- Basic Attributes
newtype GermplasmId =
    GermplasmId Int
    deriving (Show, Read, Eq, PathPiece)

instance ToPersistKey GermplasmId where
  toKey (GermplasmId x) =  toSqlKey . intToInt64 $ x

instance ToJSON GermplasmId where
  toJSON (GermplasmId x) = toJSON x

newtype GermplasmName =
    GermplasmName Text
    deriving (Show, Eq)

instance ToJSON GermplasmName where
  toJSON (GermplasmName x) = toJSON x

newtype CreatedOn =
    CreatedOn UTCTime
    deriving (Show, Eq)

instance ToJSON CreatedOn where
  toJSON (CreatedOn x) = toJSON x

newtype UpdatedOn =
    UpdatedOn UTCTime
    deriving (Show, Eq)

instance ToJSON UpdatedOn where
  toJSON (UpdatedOn x) = toJSON x

newtype DeletedOn =
    DeletedOn UTCTime
    deriving (Show, Eq)

instance ToJSON DeletedOn where
  toJSON (DeletedOn x) = toJSON x

-- Optional Attributes
newtype AttributeName
  = AttributeName Text
  deriving (Show, Eq, Read, Ord, A.ToJSONKey)

instance ToJSONKeyText AttributeName where
  toJSONKeyText (AttributeName x) = x

instance Hashable AttributeName where
  hashWithSalt salt (AttributeName x) = hashWithSalt salt x
  hash (AttributeName x) = hash x

data AttributeValue
  = AttributeText Text
  | AttributeNumber Double
  | AttributeBool Bool
  | AttributeDateTime UTCTime
  deriving (Show, Read, Eq)

instance A.ToJSON AttributeValue where
  toJSON (AttributeText x)     = A.toJSON x
  toJSON (AttributeNumber x)   = A.toJSON x
  toJSON (AttributeBool x)     = A.toJSON x
  toJSON (AttributeDateTime x) = A.toJSON x

instance ToValue AttributeValue where
  toValue (AttributeText x)     = A.String x
  toValue (AttributeNumber x)   = A.Number . fromFloatDigits $ x
  toValue (AttributeBool x)     = A.Bool x
  toValue (AttributeDateTime x) = A.String . tshow $ x

type Attributes = HashMap AttributeName AttributeValue

-- Specific Attributes
newtype GermplasmCount =
    GermplasmCount Int
    deriving (Show, Eq)

newtype Plot =
    Plot String
    deriving (Show, Eq)

