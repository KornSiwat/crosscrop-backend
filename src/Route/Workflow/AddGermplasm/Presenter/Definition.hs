{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasm.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.WorkflowPresenter.Definition

newtype WorkflowAddGermplasmPresenter
    = WorkflowAddGermplasmPresenter
        { _workflow :: WorkflowPresenter
        }
    deriving (Show, Generic)

instance ToJSON WorkflowAddGermplasmPresenter where
    toJSON = genericToJSON toJSONOptions
