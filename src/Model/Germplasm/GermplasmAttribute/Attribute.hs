{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}

module Model.Germplasm.GermplasmAttribute.Attribute where

import           ClassyPrelude.Yesod  hiding (Null, Number, String)

import qualified Data.Aeson           as A

import           Data.Scientific

import           Helper.TypeConverter

-- Basic Attributes
newtype GermplasmAttributeName
    = GermplasmAttributeName Text
    deriving (Show, Read, Eq, FromJSON, PathPiece)

instance ToJSON GermplasmAttributeName where
    toJSON (GermplasmAttributeName x) = toJSON x

data GermplasmAttributeType
    = String
    | Number
    | Date
    | DateTime
    | Boolean
    deriving (Show, Read, Eq)

instance ToJSON GermplasmAttributeType where
    toJSON String   = A.String "string"
    toJSON Number   = A.String "number"
    toJSON Date     = A.String "date"
    toJSON DateTime = A.String "dateTime"
    toJSON Boolean  = A.String "boolean"

instance FromJSON GermplasmAttributeType  where
  parseJSON (A.String s) = case unpack s of
    "string"   -> return String
    "number"   -> return Number
    "date"     -> return Date
    "dateTime" -> return DateTime
    "boolean"  -> return Boolean
    s'         -> error $ "Json format not expected. Got: " ++ s'
  parseJSON x =  error $ "Json format not expected. Got: " ++ show x

data GermplasmAttributeValue
    = GermplasmAttributeString Text
    | GermplasmAttributeNumber Double
    | GermplasmAttributeBool Bool
    | GermplasmAttributeDateTime UTCTime
    | GermplasmAttributeNull
    deriving (Show, Read, Eq)

instance A.ToJSON GermplasmAttributeValue where
    toJSON (GermplasmAttributeString x)   = A.toJSON x
    toJSON (GermplasmAttributeNumber x)   = A.toJSON x
    toJSON (GermplasmAttributeBool x)     = A.toJSON x
    toJSON (GermplasmAttributeDateTime x) = A.toJSON x
    toJSON GermplasmAttributeNull         = A.Null

instance FromJSON GermplasmAttributeValue  where
  parseJSON (A.String x) = case parseDateTime <|> parseString of
                               Just x' -> return x'
                               Nothing ->  error "Parse GermplasmAttributeValue String Error"
                        where parseDateTime = GermplasmAttributeDateTime <$> parseUTCTime x
                              parseString = Just $ GermplasmAttributeString x
  parseJSON (A.Number x) = return $ GermplasmAttributeNumber (toRealFloat x::Double)
  parseJSON (A.Bool x) = return $ GermplasmAttributeBool x
  parseJSON A.Null =  return GermplasmAttributeNull
  parseJSON x =  error $ "Json format not expected. Got: " ++ show x
