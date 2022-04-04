{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Workflow      as M

import qualified Repository.Workflow as RP

deleteWorkflowById :: M.WorkflowId
                   -> Handler (Either Error ())
deleteWorkflowById = RP.deleteOne

