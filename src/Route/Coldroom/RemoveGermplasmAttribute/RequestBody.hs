{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Coldroom.RemoveGermplasmAttribute.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

newtype ColdroomRemoveGermplasmAttributeRequestBody
    = ColdroomRemoveGermplasmAttributeRequestBody
        { _name                   :: M.GermplasmAttributeName
        }
    deriving (Show, Generic)

instance FromJSON ColdroomRemoveGermplasmAttributeRequestBody where
    parseJSON = withObject "ColdroomRemoveGermplasmAttributeRequestBody" parseColdroomRemoveGermplasmAttributeRequestBody
        where
        parseColdroomRemoveGermplasmAttributeRequestBody x = do
            name <- x .: "name"

            return $ ColdroomRemoveGermplasmAttributeRequestBody name

makeFieldsNoPrefix ''ColdroomRemoveGermplasmAttributeRequestBody
