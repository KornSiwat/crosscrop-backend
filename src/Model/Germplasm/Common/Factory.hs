{-# LANGUAGE NoImplicitPrelude #-}

module Model.Germplasm.Common.Factory where

import           Import                            hiding (map)

import           Data.Either.Combinators
import qualified Data.HashMap.Lazy                 as HM
import           Data.Scientific

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Germplasm.Common.Attribute
import           Model.Germplasm.Common.Definition

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
    let attributes' = attributesFromJsonB . germplasmEntityAttributes $ val
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
emptyAttributes :: Attributes
emptyAttributes = HM.empty

attributesFromMapTextValue :: HashMap Text Value -> Either Error Attributes
attributesFromMapTextValue = sequence . HM.map attributeValueFromValue . HM.mapKeys attributeNameFromText

attributeNameFromText :: Text -> AttributeName
attributeNameFromText = AttributeName

attributeValueFromValue :: Value -> Either Error AttributeValue
attributeValueFromValue (String x) = maybeToRight ToBeDefinedError $ parseDateTime <|> parseString
                        where parseDateTime = AttributeDateTime <$> parseUTCTime x
                              parseString = Just $ AttributeText x

attributeValueFromValue (Number x) = Right $ AttributeNumber (toRealFloat x::Double)

attributeValueFromValue (Bool x)   = Right $ AttributeBool x

attributeValueFromValue _            = Left ToBeDefinedError

attributesFromJsonB :: JsonB -> Either Error Attributes
attributesFromJsonB (JsonB (Object x)) = attributesFromMapTextValue x
attributesFromJsonB _                  = Left ToBeDefinedError
