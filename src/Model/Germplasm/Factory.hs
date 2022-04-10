{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Model.Germplasm.Factory where

import           Import

import qualified Data.Aeson                         as A
import           Data.Either.Combinators
import           Data.Scientific

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Common.Attribute
import           Model.Germplasm.Attribute
import           Model.Germplasm.Definition
import           Model.Germplasm.GermplasmAttribute

import           Persist.Entity

-- Germplasm
makeGermplasm :: GermplasmId
              -> GermplasmName
              -> [GermplasmAttribute]
              -> CreatedOn
              -> Maybe UpdatedOn
              -> Maybe DeletedOn
              -> Either Error Germplasm
makeGermplasm a b c d e f = Right $ Germplasm a b c d e f

fromEntity :: Entity GermplasmEntity
           -> Either Error Germplasm
fromEntity entity = do
    let key = entityKey entity
    let val = entityVal entity

    let id' = germplasmIdFromKey key
    let name' = GermplasmName . germplasmEntityName $ val
    let attributes' = maybeToEither
                          (ParsingError "Parsing GermplasmAttribute from Text Error")
                          (mapM
                              (\x ->
                                  treadMaybe x:: Maybe GermplasmAttribute)
                              (germplasmEntityAttributes val))
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
germplasmIdFromKey :: Key GermplasmEntity
                   -> GermplasmId
germplasmIdFromKey = GermplasmId . int64ToInt . fromSqlKey

germplasmAttributeValueFromValue :: A.Value
                                 -> Either Error GermplasmAttributeValue
germplasmAttributeValueFromValue (A.String x) = maybeToRight ToBeDefinedError $ parseDateTime <|> parseString
                        where parseDateTime = GermplasmAttributeDateTime <$> parseUTCTime x
                              parseString = Just $ GermplasmAttributeString x

germplasmAttributeValueFromValue (A.Number x) = Right $ GermplasmAttributeNumber (toRealFloat x::Double)

germplasmAttributeValueFromValue (A.Bool x)   = Right $ GermplasmAttributeBool x

germplasmAttributeValueFromValue _            = Left ToBeDefinedError
