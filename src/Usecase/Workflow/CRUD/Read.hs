{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Read where

import           Import

import           Error.Definition

import qualified Model.Season        as M.SS
import qualified Model.Workflow      as M.WF

import qualified Repository.Workflow as RP

getAllWorkflow :: Handler (Either Error [M.WF.Workflow])
getAllWorkflow = RP.getAll

getWorkflowsBySeasonId :: M.SS.SeasonId
                       -> Handler (Either Error [M.WF.Workflow])
getWorkflowsBySeasonId = RP.getBySeasonId

getWorkflowsByType :: M.WF.WorkflowType
                   -> Handler (Either Error [M.WF.Workflow])
getWorkflowsByType = RP.getByType

getWorkflowsBySeasonIdAndType :: M.SS.SeasonId
                              -> M.WF.WorkflowType
                              -> Handler (Either Error [M.WF.Workflow])
getWorkflowsBySeasonIdAndType = RP.getBySeasonIdAndType

getWorkflowById :: M.WF.WorkflowId
                -> Handler (Either Error M.WF.Workflow)
getWorkflowById = RP.getById

getWorkflowByIds :: [M.WF.WorkflowId]
                 -> Handler (Either Error [M.WF.Workflow])
getWorkflowByIds = RP.getByIds
