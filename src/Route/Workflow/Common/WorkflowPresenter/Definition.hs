{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Common.WorkflowPresenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions

import           Model.Common.Attribute
import           Model.Workflow

import           Route.Germplasm.Common.GermplasmPresenter.Definition (GermplasmPresenter)

data WorkflowPresenter = WorkflowPresenter
    { _id         :: WorkflowId
    , _name       :: WorkflowName
    , _germplasms :: [GermplasmPresenter]
    , _createdOn  :: CreatedOn
    , _updatedOn  :: Maybe UpdatedOn
    } deriving (Show, Generic)

instance ToJSON WorkflowPresenter where
    toJSON = genericToJSON toJSONOptions

