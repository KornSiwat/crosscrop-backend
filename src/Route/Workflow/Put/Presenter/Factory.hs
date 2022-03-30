{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Put.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.Common.Presenter
import           Route.Workflow.Put.Presenter.Definition

makePutWorkflowPresenter :: Workflow -> PutWorkflowPresenter
makePutWorkflowPresenter = PutWorkflowPresenter . fromWorkflow

