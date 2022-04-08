{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.CRUD.Put.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Workflow                            as M

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.CRUD.Put.Presenter.Factory
import           Route.Workflow.CRUD.Put.RequestBody

import qualified Usecase.Workflow                          as UC

putOneWorkflowR :: M.WorkflowId
                -> Handler Value
putOneWorkflowR id = do
    body <- parseJSONBody :: Handler (Either Error PutWorkflowRequestBody)

    workflow <- join <$> sequence
                     (UC.updateWorkflow
                             id
                         <$> body&^.name
                         <*> body&^.seasonId)

    let presenter = makePutWorkflowPresenter <$> workflow

    sendResponse status200 presenter
