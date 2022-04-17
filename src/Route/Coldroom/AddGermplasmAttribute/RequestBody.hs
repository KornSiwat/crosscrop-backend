{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Coldroom.AddGermplasmAttribute.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

data ColdroomAddGermplasmAttributeRequestBody
    = ColdroomAddGermplasmAttributeRequestBody
        { _name                   :: M.GermplasmAttributeName
        , _germplasmAttributeType :: M.GermplasmAttributeType
        }
    deriving (Show, Generic)

instance FromJSON ColdroomAddGermplasmAttributeRequestBody where
    parseJSON = withObject "ColdroomAddGermplasmAttributeRequestBody" parseColdroomAddGermplasmAttributeRequestBody
        where
        parseColdroomAddGermplasmAttributeRequestBody x = do
            name <- x .: "name"
            germplasmAttributeType <- x .: "type"

            return $ ColdroomAddGermplasmAttributeRequestBody
                         name
                         germplasmAttributeType

makeFieldsNoPrefix ''ColdroomAddGermplasmAttributeRequestBody
