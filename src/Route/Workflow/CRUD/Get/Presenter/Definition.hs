{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Get.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.Presenter

newtype GetOneWorkflowPresenter = GetOneWorkflowPresenter {
    _workflow :: WorkflowPresenter
} deriving (Show, Generic)

instance ToJSON GetOneWorkflowPresenter where
    toJSON = genericToJSON toJSONOptions

