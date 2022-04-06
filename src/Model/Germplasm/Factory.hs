{-# LANGUAGE NoImplicitPrelude #-}

module Model.Germplasm.Factory where

import           Import                     hiding (map)

import           Data.Either.Combinators
import qualified Data.HashMap.Lazy          as HM
import           Data.Scientific

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Common.Attribute
import           Model.Germplasm.Attribute
import           Model.Germplasm.Definition

import           Persist.Entity
import           Persist.Field.JsonB

-- Germplasm
makeGermplasm :: GermplasmId
              -> GermplasmName
              -> Attributes
              -> CreatedOn
              -> Maybe UpdatedOn
              -> Maybe DeletedOn
              -> Either Error Germplasm
makeGermplasm a b c d e f = Right $ Germplasm a b c d e f

fromEntity :: Entity GermplasmEntity -> Either Error Germplasm
fromEntity entity = do
    let key = entityKey entity
    let val = entityVal entity

    let id' = germplasmIdFromKey key
    let name' = GermplasmName . germplasmEntityName $ val
    let attributes' = fromJsonB . germplasmEntityAttributes $ val
    let createdOn' = CreatedOn . germplasmEntityCreatedOn $ val
    let updatedOn' = UpdatedOn <$> germplasmEntityUpdatedOn val
    let deletedOn' = DeletedOn <$> germplasmEntityDeletedOn val

    join $ makeGermplasm
                    id'
                    name'
                    <$> attributes'
                    <*> pure createdOn'
                    <*> pure updatedOn'
                    <*> pure deletedOn'

-- GermplasmId
germplasmIdFromKey :: Key GermplasmEntity -> GermplasmId
germplasmIdFromKey = GermplasmId . int64ToInt . fromSqlKey

-- Attributes
empty :: Attributes
empty = HM.empty

fromMapTextValue :: HashMap Text Value -> Either Error Attributes
fromMapTextValue = sequence . HM.map valueFromValue . HM.mapKeys nameFromText

nameFromText :: Text -> AttributeName
nameFromText = AttributeName

valueFromValue :: Value -> Either Error AttributeValue
valueFromValue (String x) = maybeToRight ToBeDefinedError $ parseDateTime <|> parseString
                        where parseDateTime = AttributeDateTime <$> parseUTCTime x
                              parseString = Just $ AttributeText x

valueFromValue (Number x) = Right $ AttributeNumber (toRealFloat x::Double)

valueFromValue (Bool x)   = Right $ AttributeBool x

valueFromValue _            = Left ToBeDefinedError

fromJsonB :: JsonB -> Either Error Attributes
fromJsonB (JsonB (Object x)) = fromMapTextValue x
fromJsonB _                  = Left ToBeDefinedError

