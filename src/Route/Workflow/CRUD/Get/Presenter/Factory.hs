{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Get.Presenter.Factory where

import           Import

import           Model.Workflow

import           Route.Workflow.CRUD.Get.Presenter.Definition
import           Route.Workflow.Common.Presenter

makeGetOneWorkflowPresenter :: Workflow -> GetOneWorkflowPresenter
makeGetOneWorkflowPresenter = GetOneWorkflowPresenter . fromWorkflow

