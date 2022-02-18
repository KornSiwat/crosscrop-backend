{-# LANGUAGE NoImplicitPrelude #-}

module Model.Germplasm.Common.Factory where

import           Control.Applicative                  ((<|>))
import           Control.Monad
import           Data.Aeson                           as A
import           Data.Either.Combinators
import           Data.HashMap.Lazy
import           Data.Scientific                      (toRealFloat)
import           Data.Text                            (Text)
import           Database.Persist.Class.PersistEntity
import           Database.Persist.Sql
import           Error.Definition

import           Helper.TypeConverter
import           Model.Germplasm.Common.Attribute
import           Model.Germplasm.Common.Definition
import           Persist.Entity                       as E
import           Persist.Field.JsonB                  (JsonB (..))
import           Prelude                              hiding (id, map)

-- Germplasm
makeGermplasm ::
     GermplasmId -> GermplasmName -> Attributes -> Either Error Germplasm
makeGermplasm x y z = Right $ Germplasm x y z

fromEntity :: Entity GermplasmEntity -> Either Error Germplasm
fromEntity entity = do
     let key = entityKey entity
     let val = entityVal entity

     let id' = GermplasmId . int64ToInt . fromSqlKey $ key
     let name' = GermplasmName . germplasmEntityName $ val
     let attributes' = attributesFromJsonB . germplasmEntityAttributes $ val

     makeGermplasm id' name' =<< attributes'

-- Attributes
emptyAttributes :: Attributes
emptyAttributes = empty

attributesFromMapTextValue :: HashMap Text Value -> Either Error Attributes
attributesFromMapTextValue = sequence . (map attributeValueFromValue) . (mapKeys attributeNameFromText)

attributeNameFromText :: Text -> AttributeName
attributeNameFromText = AttributeName

attributeValueFromValue :: A.Value -> Either Error AttributeValue
attributeValueFromValue (A.String x) = maybeToRight ToBeDefinedError $ parseDateTime <|> parseString
                        where parseDateTime = AttributeDateTime <$> parseUTCTime x
                              parseString = Just $ AttributeText x
attributeValueFromValue (A.Number x) = Right $ AttributeNumber (toRealFloat x::Double)
attributeValueFromValue (A.Bool x)   = Right $ AttributeBool x
attributeValueFromValue _            = Left ToBeDefinedError

attributesFromJsonB :: JsonB -> Either Error Attributes
attributesFromJsonB (JsonB (Object x)) = do
     attributesFromMapTextValue x
attributesFromJsonB _ = Left ToBeDefinedError
