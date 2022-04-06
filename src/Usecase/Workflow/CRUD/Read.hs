{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Read where

import           Import

import           Error.Definition

import qualified Model.Workflow      as M

import qualified Repository.Workflow as RP

getAllWorkflow :: Handler (Either Error [M.Workflow])
getAllWorkflow = RP.getAll

getWorkflowById :: M.WorkflowId
                -> Handler (Either Error M.Workflow)
getWorkflowById = RP.getById

getWorkflowByIds :: [M.WorkflowId]
                 -> Handler (Either Error [M.Workflow])
getWorkflowByIds = RP.getByIds

