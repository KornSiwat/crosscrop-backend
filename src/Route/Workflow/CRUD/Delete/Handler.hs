{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Workflow.CRUD.Delete.Handler where

import           Import

import qualified Model.Workflow        as M

import           Route.Common.Response

import qualified Usecase.Workflow      as UC

deleteOneWorkflowR :: M.WorkflowId -> Handler Value
deleteOneWorkflowR id = do
    deleteResult <- UC.deleteWorkflowById id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

