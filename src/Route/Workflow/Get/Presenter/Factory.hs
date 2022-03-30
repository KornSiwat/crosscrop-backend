{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Get.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.Common.Presenter
import           Route.Workflow.Get.Presenter.Definition

makeGetOneWorkflowPresenter :: Workflow -> GetOneWorkflowPresenter
makeGetOneWorkflowPresenter = GetOneWorkflowPresenter . fromWorkflow

