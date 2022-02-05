{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Model.Germplasm.Common.Attribute where

import           Data.Aeson           as A
import           Data.HashMap.Lazy
import           Data.Hashable
import           Data.Text
import           Data.Time            (UTCTime)

import           Class.ToKey
import           Database.Persist.Sql
import           Helper.TypeConverter

-- Basic Attributes
newtype GermplasmId =
    GermplasmId Int
    deriving (Show, Eq)

instance ToKey GermplasmId where
  toKey (GermplasmId x) =  toSqlKey . intToInt64 $ x

newtype GermplasmName =
    GermplasmName Text
    deriving (Show, Eq)

newtype AttributeName
  = AttributeName Text
  deriving (Show, Eq, Read, Ord, A.ToJSONKey)

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

type Attributes = HashMap AttributeName AttributeValue

-- Specific Attributes
newtype GermplasmCount =
    GermplasmCount Int
    deriving (Show, Eq)

newtype Plot =
    Plot String
    deriving (Show, Eq)
