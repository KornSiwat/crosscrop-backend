{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasmAttribute.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.WorkflowPresenter.Definition

newtype WorkflowAddGermplasmAttributePresenter
    = WorkflowAddGermplasmAttributePresenter
        { _workflow :: WorkflowPresenter
        }
    deriving (Show, Generic)

instance ToJSON WorkflowAddGermplasmAttributePresenter where
    toJSON = genericToJSON toJSONOptions
