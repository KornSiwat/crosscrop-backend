{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.Put.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson
import qualified Data.HashMap.Lazy              as HM

import           Route.Germplasm.Common.Request

data PutGermplasmRequestBody = PutGermplasmRequestBody {
    _id         :: Int,
    _name       :: Text,
    _attributes ::  HashMap Text Value
} deriving (Show)

instance FromJSON PutGermplasmRequestBody where
    parseJSON = withObject "PutGermplasmRequestBody" parsePutGermplasmRequestBody
        where
        parsePutGermplasmRequestBody x = do
            id <- x .: "id"
            name <- x .: "name"

            let attributes = foldr HM.delete x germplasmMainAttributeNames

            return $ PutGermplasmRequestBody id name attributes

makeFieldsNoPrefix ''PutGermplasmRequestBody

