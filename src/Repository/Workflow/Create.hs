{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Workflow.Create where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Season       as M.Season
import qualified Model.Workflow     as M.Workflow

import           Persist.Entity

import           Repository.Common

createWorkflow :: M.Workflow.WorkflowType
               -> M.Workflow.WorkflowName
               -> M.Season.SeasonId
               -> Handler (Either Error M.Workflow.WorkflowId)
createWorkflow workflowType name seasonId = do
    currentTime <- liftIO getCurrentTime

    let workflowType' = tshow workflowType
    let (M.Workflow.WorkflowName name') = name
    let seasonId' = toKey seasonId
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = WorkflowEntity
                     workflowType'
                     name'
                     seasonId'
                     createdOn
                     updatedOn
                     deletedOn

    key <- runDB $ insert entity

    return $ M.Workflow.workflowIdFromKey <$> key
