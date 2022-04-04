{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.Get.Handler where

import           Import

import qualified Model.Workflow                       as M

import           Route.Common.Response
import           Route.Workflow.Get.Presenter.Factory

import qualified Usecase.Workflow                     as UC

getOneWorkflowR :: M.WorkflowId -> Handler Value
getOneWorkflowR id = do
    workflow <- UC.getWorkflowById id

    let presenter = makeGetOneWorkflowPresenter <$> workflow

    sendResponse status200 presenter

