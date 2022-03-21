{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.Put.RequestBody where

import           Control.Lens
import           Import

import           Data.Aeson
import qualified Data.HashMap.Lazy as HM

data PutGermplasmRequestBody = PutGermplasmRequestBody {
    _id         :: Int,
    _name       :: Text,
    _workflowId :: Maybe Int,
    _attributes ::  HashMap Text Value
} deriving (Show)

instance FromJSON PutGermplasmRequestBody where
    parseJSON = withObject "PutGermplasmRequestBody" parsePutGermplasmRequestBody
        where
        parsePutGermplasmRequestBody x = do
            id <- x .: "id"
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"

            let attributes = foldr HM.delete x ["id", "name", "workflow_id"]

            return $ PutGermplasmRequestBody id name workflowId attributes

makeFieldsNoPrefix ''PutGermplasmRequestBody

