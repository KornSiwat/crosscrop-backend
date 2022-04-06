{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Workflow.CRUD.Post.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M
import qualified Model.Season    as M
import qualified Model.Workflow  as M

data PostWorkflowRequestBody = PostWorkflowRequestBody {
    _workflowType :: M.WorkflowType,
    _name         :: M.WorkflowName,
    _seasonId     :: Maybe M.SeasonId,
    _germplasmIds :: Maybe [M.GermplasmId]
    } deriving (Show, Generic)

instance FromJSON PostWorkflowRequestBody where
    parseJSON = withObject "PostWorkflowRequestBody" parsePostWorkflowRequestBody
        where
        parsePostWorkflowRequestBody x = do
            workflowType <- x .: "workflow_type"
            name <- x .: "name"
            seasonId <- x .:? "season_id"
            germplasmIds <- x .:? "germplasm_ids"

            return $ PostWorkflowRequestBody
                         workflowType
                         name
                         seasonId
                         germplasmIds

makeFieldsNoPrefix ''PostWorkflowRequestBody

