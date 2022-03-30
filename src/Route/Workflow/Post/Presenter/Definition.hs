{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Model.Workflow

import           Route.Common.JSONOptions

newtype PostWorkflowPresenter = PostWorkflowPresenter {
    _workflowId :: WorkflowId
} deriving (Show, Generic)

instance ToJSON PostWorkflowPresenter where
    toJSON = genericToJSON toJSONOptions

