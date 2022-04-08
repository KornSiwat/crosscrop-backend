{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Create where

import           Import

import           Error.Definition

import qualified Model.Season        as M.SS
import qualified Model.Workflow      as M.WF

import qualified Repository.Workflow as RP

createWorkflow :: M.WF.WorkflowType
               -> M.WF.WorkflowName
               -> M.SS.SeasonId
               -> Handler (Either Error M.WF.Workflow)
createWorkflow workflowType name seasonId =  do
    workflowId <- RP.createWorkflow
                      workflowType
                      name
                      seasonId

    let workflow = join <$> sequence (RP.getById <$> workflowId)

    workflow
