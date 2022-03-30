{-# LANGUAGE NoImplicitPrelude #-}

module Model.Workflow.Common.Factory where

import           Import

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Common.Attribute
import qualified Model.Germplasm                  as GP
import           Model.Season                     as SS
import           Model.Workflow.Common.Attribute
import           Model.Workflow.Common.Definition

import           Persist.Entity

-- Workflow
makeWorkflow :: WorkflowId
             -> WorkflowName
             -> [GP.Germplasm]
             -> Maybe Season
             -> CreatedOn
             -> Maybe UpdatedOn
             -> Maybe DeletedOn
             -> Either Error Workflow
makeWorkflow a b c d e f g = Right $ Workflow a b c d e f g

fromEntity :: Entity WorkflowEntity
           -> [GP.Germplasm]
           -> Maybe SS.Season
           -> Either Error Workflow
fromEntity workflowEntity germplasms' season' = do
    let key = entityKey workflowEntity
    let val = entityVal workflowEntity

    let id' = workflowIdFromKey key
    let name' = WorkflowName . workflowEntityName $ val
    let createdOn' = CreatedOn . workflowEntityCreatedOn $ val
    let updatedOn' = UpdatedOn <$> workflowEntityUpdatedOn val
    let deletedOn' = DeletedOn <$> workflowEntityDeletedOn val

    makeWorkflow
            id'
            name'
            germplasms'
            season'
            createdOn'
            updatedOn'
            deletedOn'

-- WorkflowId
workflowIdFromKey :: Key WorkflowEntity -> WorkflowId
workflowIdFromKey = WorkflowId . int64ToInt . fromSqlKey

