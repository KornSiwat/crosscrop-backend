{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Model.Germplasm.Common.Attribute where

import           Data.Aeson           as A
import           Data.Map             (Map)
import           Data.Scientific
import           Data.Text
import           Data.Time            (UTCTime)
import           Database.Persist.Sql

import           Class.ToKey
import           Helper.Converter


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

data AttributeValue
  = AttributeString Text
  | AttributeInt Int
  | AttributeDouble Double
  | AttributeBool Bool
  | AttributeDateTime UTCTime
  deriving (Show, Read, Eq)

instance A.ToJSON AttributeValue where
  toJSON (AttributeString x)   = A.toJSON x
  toJSON (AttributeInt x)      = A.toJSON x
  toJSON (AttributeDouble x)   = A.toJSON x
  toJSON (AttributeBool x)     = A.toJSON x
  toJSON (AttributeDateTime x) = A.toJSON x

type Attributes = Map AttributeName AttributeValue

fromValue :: A.Value -> Maybe AttributeValue
fromValue (A.Object _) = Nothing
fromValue (A.Array _) = Nothing
fromValue (A.String x) = Just $ AttributeString x
fromValue (A.Number x)
  | isInteger x = AttributeInt <$> toBoundedInteger x
  | isFloating x = Just $ AttributeDouble (toRealFloat x :: Double)
  | otherwise = Nothing
fromValue (A.Bool x) = Just $ AttributeBool x
fromValue A.Null = Nothing

-- Specific Attributes
newtype GermplasmCount =
    GermplasmCount Int
    deriving (Show, Eq)

newtype Plot =
    Plot String
    deriving (Show, Eq)
