{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.RemoveGermplasmAttribute.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Workflow.Common.WorkflowPresenter.Definition

newtype WorkflowRemoveGermplasmAttributePresenter
    = WorkflowRemoveGermplasmAttributePresenter
        { _workflow :: WorkflowPresenter
        }
    deriving (Show, Generic)

instance ToJSON WorkflowRemoveGermplasmAttributePresenter where
    toJSON = genericToJSON toJSONOptions
