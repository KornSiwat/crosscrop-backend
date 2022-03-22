{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.Post.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson
import qualified Data.HashMap.Lazy              as HM

import           Route.Germplasm.Common.Request

data PostGermplasmRequestBody = PostGermplasmRequestBody {
    _name       :: Text,
    _workflowId :: Maybe Int,
    _attributes ::  HashMap Text Value
} deriving (Show)

instance FromJSON PostGermplasmRequestBody where
    parseJSON = withObject "PostGermplasmRequestBody" parsePostGermplasmRequestBody
        where
        parsePostGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"
            let attributes = foldr HM.delete x germplasmMainAttributeNames

            return $ PostGermplasmRequestBody name workflowId attributes

makeFieldsNoPrefix ''PostGermplasmRequestBody

