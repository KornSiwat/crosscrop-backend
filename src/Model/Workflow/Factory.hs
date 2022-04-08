{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Model.Workflow.Factory where

import           Import

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Common.Attribute
import qualified Model.Germplasm           as GP
import           Model.Season              as SS
import           Model.Workflow.Attribute
import           Model.Workflow.Definition

import           Persist.Entity

-- Workflow
makeWorkflow :: WorkflowId
             -> WorkflowType
             -> WorkflowName
             -> [GP.Germplasm]
             -> Season
             -> CreatedOn
             -> Maybe UpdatedOn
             -> Maybe DeletedOn
             -> Either Error Workflow
makeWorkflow a b c d e f g h = Right $ Workflow a b c d e f g h

fromEntity :: Entity WorkflowEntity
           -> [GP.Germplasm]
           -> SS.Season
           -> Either Error Workflow
fromEntity workflowEntity germplasms' season' = do
    let key = entityKey workflowEntity
    let val = entityVal workflowEntity

    let id' = workflowIdFromKey key
    let workflowType' = maybeToEither
                            (TypeConversionError "Parsing Workflow Error")
                            ((treadMaybe . workflowEntityWorkflowType $ val):: Maybe WorkflowType)
    let name' = WorkflowName . workflowEntityName $ val
    let createdOn' = CreatedOn . workflowEntityCreatedOn $ val
    let updatedOn' = UpdatedOn <$> workflowEntityUpdatedOn val
    let deletedOn' = DeletedOn <$> workflowEntityDeletedOn val

    join $ makeWorkflow
                   id'
               <$> workflowType'
               <*> pure name'
               <*> pure germplasms'
               <*> pure season'
               <*> pure createdOn'
               <*> pure updatedOn'
               <*> pure deletedOn'

-- WorkflowId
workflowIdFromKey :: Key WorkflowEntity 
                  -> WorkflowId
workflowIdFromKey = WorkflowId . int64ToInt . fromSqlKey
