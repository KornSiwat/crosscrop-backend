{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Put.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.CRUD.Put.Presenter.Definition
import           Route.Workflow.Common.Presenter

makePutWorkflowPresenter :: Workflow
                         -> PutWorkflowPresenter
makePutWorkflowPresenter = PutWorkflowPresenter . fromWorkflow
