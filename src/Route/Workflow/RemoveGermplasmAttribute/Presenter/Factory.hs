{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.RemoveGermplasmAttribute.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.Common.Presenter
import           Route.Workflow.RemoveGermplasmAttribute.Presenter.Definition

makeWorkflowRemoveGermplasmAttributePresenter :: Workflow
                                              -> WorkflowRemoveGermplasmAttributePresenter
makeWorkflowRemoveGermplasmAttributePresenter
    = WorkflowRemoveGermplasmAttributePresenter . fromWorkflow
