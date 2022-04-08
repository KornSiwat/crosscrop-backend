{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Post.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.CRUD.Post.Presenter.Factory
import           Route.Workflow.CRUD.Post.RequestBody

import qualified Usecase.Workflow                           as UC

postWorkflowR :: Handler Value
postWorkflowR = do
    body <- parseJSONBody :: Handler (Either Error PostWorkflowRequestBody)

    workflow <- join <$> sequence
                      (UC.createWorkflow
                          <$> body&^.workflowType
                          <*> body&^.name
                          <*> body&^.seasonId)

    let presenter = makePostWorkflowPresenter <$> workflow

    sendResponse status201 presenter
