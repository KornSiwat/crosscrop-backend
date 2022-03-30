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

import qualified Model.Germplasm                as M.Germplasm
import qualified Model.Workflow                 as M.Workflow

import           Route.Germplasm.Common.Request

data PutGermplasmRequestBody = PutGermplasmRequestBody {
    _name       :: M.Germplasm.GermplasmName,
    _workflowId :: Maybe M.Workflow.WorkflowId,
    _attributes :: M.Germplasm.Attributes
} deriving (Show)

instance FromJSON PutGermplasmRequestBody where
    parseJSON = withObject "PutGermplasmRequestBody" parsePutGermplasmRequestBody
        where
        parsePutGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"
            let attributes = M.Germplasm.fromMapTextValue $ foldr HM.delete x germplasmMainAttributeNames

            case attributes of
                Right attributes' -> return $ PutGermplasmRequestBody name workflowId attributes'
                Left e -> error $ show e

makeFieldsNoPrefix ''PutGermplasmRequestBody

