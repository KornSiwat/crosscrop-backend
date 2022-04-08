{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Put.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.Presenter

newtype PutWorkflowPresenter
    = PutWorkflowPresenter
        { _workflow :: WorkflowPresenter
        }
    deriving (Show, Generic)

instance ToJSON PutWorkflowPresenter where
    toJSON = genericToJSON toJSONOptions
