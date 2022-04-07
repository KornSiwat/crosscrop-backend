{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Coldroom.AddGermplasm.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

newtype ColdroomAddGermplasmRequestBody = ColdroomAddGermplasmRequestBody {
    _germplasmIds :: [M.GermplasmId]
} deriving (Show, Generic)

instance FromJSON ColdroomAddGermplasmRequestBody where
    parseJSON = withObject "ColdroomAddGermplasmRequestBody" parseColdroomAddGermplasmRequestBody
        where
        parseColdroomAddGermplasmRequestBody x = do
            germplasmIds <- x .: "germplasm_ids"

            return $ ColdroomAddGermplasmRequestBody germplasmIds

makeFieldsNoPrefix ''ColdroomAddGermplasmRequestBody

