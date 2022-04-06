{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasm.Presenter.Factory where

import           Model.Workflow

import           Route.Workflow.AddGermplasm.Presenter.Definition
import           Route.Workflow.Common.Presenter

makeWorkflowAddGermplasmPresenter :: Workflow -> WorkflowAddGermplasmPresenter
makeWorkflowAddGermplasmPresenter = fromWorkflow

