{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.Presenter

newtype PostWorkflowPresenter = PostWorkflowPresenter {
    _workflow :: WorkflowPresenter
} deriving (Show, Generic)

instance ToJSON PostWorkflowPresenter where
    toJSON = genericToJSON toJSONOptions
