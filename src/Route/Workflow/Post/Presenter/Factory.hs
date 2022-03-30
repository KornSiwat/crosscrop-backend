{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Post.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.Common.Presenter
import           Route.Workflow.Post.Presenter.Definition

makePostWorkflowPresenter :: WorkflowId -> PostWorkflowPresenter
makePostWorkflowPresenter = PostWorkflowPresenter

