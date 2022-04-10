{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.GermplasmAttribute.Definition where

import           Import

import           Control.Lens                                 (makeFieldsNoPrefix)

import           Data.Aeson

import           Model.Germplasm.GermplasmAttribute.Attribute

-- GermplasmAttribute
data GermplasmAttribute
    = GermplasmAttribute
        { _name                    :: GermplasmAttributeName
        , _germplasmAttributeType  :: GermplasmAttributeType
        , _germplasmAttributeValue :: GermplasmAttributeValue
        }
    deriving (Show, Read, Eq, Generic)


instance ToJSON GermplasmAttribute where
    toJSON (GermplasmAttribute
               name
               germplasmAttributeType
               germplasmAttributeValue)
               = object ["name" .= name
                        , "type" .= germplasmAttributeType
                        , "value" .= germplasmAttributeValue
                        ]

instance FromJSON GermplasmAttribute where
    parseJSON = withObject "GermplasmAttribute" parseGermplasmAttribute
        where
        parseGermplasmAttribute x = do
            name <- x .: "name"
            germplasmAttributeType <- x .: "type"
            germplasmAttributeValue <- x .: "value"

            return $ GermplasmAttribute
                         name
                         germplasmAttributeType
                         germplasmAttributeValue

makeFieldsNoPrefix ''GermplasmAttribute
