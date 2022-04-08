{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Workflow             as M

import qualified Repository.Workflow        as RP

import qualified Usecase.Workflow.CRUD.Read as UC

deleteWorkflowById :: M.WorkflowId
                   -> Handler (Either Error ())
deleteWorkflowById id = do
    existingWorkflow <- UC.getWorkflowById id

    join <$> sequence
        (existingWorkflow $> RP.deleteOne id)
