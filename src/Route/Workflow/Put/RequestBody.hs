{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Workflow.Put.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Season   as M
import qualified Model.Workflow as M

data PutWorkflowRequestBody = PutWorkflowRequestBody {
    _name     :: M.WorkflowName,
    _seasonId :: Maybe M.SeasonId
    } deriving (Show, Generic)

instance FromJSON PutWorkflowRequestBody where
    parseJSON = withObject "PutWorkflowRequestBody" parsePutWorkflowRequestBody
        where
        parsePutWorkflowRequestBody x = do
            name <- x .: "name"
            seasonId <- x .:? "season_id"

            return $ PutWorkflowRequestBody name seasonId

makeFieldsNoPrefix ''PutWorkflowRequestBody

