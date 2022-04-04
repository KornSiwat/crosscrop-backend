{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.CRUD.Update where

import           Import

import           Control.Lens

import           Error.Definition

import           Helper.Lens

import qualified Model.Season               as M.SS
import qualified Model.Workflow             as M.WF

import qualified Repository.Season          as RP.SS
import qualified Repository.Workflow        as RP.WF

import qualified Usecase.Workflow.CRUD.Read as UC

updateWorkflow :: M.WF.WorkflowId
               -> M.WF.WorkflowName
               -> Maybe M.SS.SeasonId
               -> Handler (Either Error M.WF.Workflow)
updateWorkflow id name seasonId =  do
    season <- sequence <$> sequence (RP.SS.getById <$> seasonId)

    existingWorkflow <- UC.getWorkflowById id

    let updateWorkflowArg = join $ existingWorkflow
                                       <&> M.WF.name .~ name
                                       <&> M.WF.season .~? season

    updateResult <- sequence (RP.WF.updateOne <$> updateWorkflowArg)

    updatedWorkflow <- UC.getWorkflowById id

    return $ join (updateResult $> updatedWorkflow)

