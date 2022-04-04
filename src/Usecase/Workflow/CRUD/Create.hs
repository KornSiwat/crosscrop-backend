{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Create where

import           Import

import           Error.Definition

import qualified Model.Season        as M.SS
import qualified Model.Workflow      as M.WF

import qualified Repository.Workflow as RP

createWorkflow :: M.WF.WorkflowName
               -> Maybe M.SS.SeasonId
               -> Handler (Either Error M.WF.Workflow)
createWorkflow name seasonId =  do
    workflowId <- RP.createWorkflow name seasonId

    let workflow = join <$> sequence (RP.getById <$> workflowId)

    workflow

