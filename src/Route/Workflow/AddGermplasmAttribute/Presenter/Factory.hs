{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasmAttribute.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.AddGermplasmAttribute.Presenter.Definition
import           Route.Workflow.Common.Presenter

makeWorkflowAddGermplasmAttributePresenter :: Workflow
                                           -> WorkflowAddGermplasmAttributePresenter
makeWorkflowAddGermplasmAttributePresenter
    = WorkflowAddGermplasmAttributePresenter . fromWorkflow
