{-# LANGUAGE NoImplicitPrelude #-}

module Model.Germplasm.Common.Factory where

import           Control.Applicative               ((<|>))
import           Data.Aeson                        as A
import           Data.HashMap.Lazy
import           Data.Scientific                   (toRealFloat)
import           Data.Text                         (Text)
import           Prelude                           hiding (id, map)

import           Error.Definition
import           Helper.TypeConverter
import           Model.Germplasm.Common.Attribute
import           Model.Germplasm.Common.Definition

makeGermplasm ::
     GermplasmId -> GermplasmName -> Attributes -> Either Error Germplasm
makeGermplasm x y z = Right $ Germplasm x y z

emptyAttributes :: Attributes
emptyAttributes = empty

attributesFromMapTextValue :: HashMap Text Value -> Maybe Attributes
attributesFromMapTextValue = sequence . (map attributeValueFromValue) . (mapKeys attributeNameFromText)

attributeNameFromText :: Text -> AttributeName
attributeNameFromText = AttributeName

attributeValueFromValue :: A.Value -> Maybe AttributeValue
attributeValueFromValue (A.String x) = parseDateTime <|> parseString
                        where parseDateTime = AttributeDateTime <$> parseUTCTime x
                              parseString = Just $ AttributeText x
attributeValueFromValue (A.Number x) = Just $ AttributeNumber (toRealFloat x::Double)
attributeValueFromValue (A.Bool x)   = Just $ AttributeBool x
attributeValueFromValue _            = Nothing
