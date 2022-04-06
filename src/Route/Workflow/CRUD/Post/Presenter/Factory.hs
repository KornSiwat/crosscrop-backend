{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Post.Presenter.Factory where

import           Model.Workflow

import           Route.Workflow.CRUD.Post.Presenter.Definition
import           Route.Workflow.Common.Presenter

makePostWorkflowPresenter :: Workflow -> PostWorkflowPresenter
makePostWorkflowPresenter = fromWorkflow
