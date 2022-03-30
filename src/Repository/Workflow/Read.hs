{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Workflow.Read where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import           Helper.TypeConverter

import qualified Model.Season              as M.SS
import qualified Model.Workflow            as M.WF

import           Persist.Entity

import           Repository.Common
import qualified Repository.Germplasm.Read as RP.GP
import qualified Repository.Season.Read    as RP.SS

getAll :: Handler (Either Error [M.WF.Workflow])
getAll = getManyBy [] []

getById :: M.WF.WorkflowId -> Handler (Either Error M.WF.Workflow)
getById id = getFirstBy [WorkflowEntityId ==. toKey id] []

getByIds :: [M.WF.WorkflowId] -> Handler (Either Error [M.WF.Workflow])
getByIds ids = getManyBy [WorkflowEntityId <-. ids'] []
    where ids' = map toKey ids

getManyBy :: [Filter WorkflowEntity]
          -> [SelectOpt WorkflowEntity]
          -> Handler (Either Error [M.WF.Workflow])
getManyBy filters selectOpts = do
    workflowEntities <- runDB $ selectList
                                    (baseFilter ++ filters)
                                    selectOpts

    let workflowModels = join <$> sequence
                             (fmap sequence <$>
                             (mapM entityToModel <$> workflowEntities))

    workflowModels

getFirstBy :: [Filter WorkflowEntity]
           -> [SelectOpt WorkflowEntity]
           -> Handler (Either Error M.WF.Workflow)
getFirstBy filters selectOpts = do
    workflowEntity' <- runDB $ selectFirst
                                  (baseFilter ++ filters)
                                  selectOpts
    let workflowEntity = maybeToEither RecordNotFound =<< workflowEntity'

    let workflowModel = join <$> sequence (entityToModel <$> workflowEntity)

    workflowModel

entityToModel :: Entity WorkflowEntity -> Handler (Either Error M.WF.Workflow)
entityToModel workflowEntity = do

    let id = entityKey workflowEntity
    germplasms <- RP.GP.getManyBy [GermplasmEntityWorkflowId ==. Just id] []

    let seasonEntityId = workflowEntitySeasonId . entityVal $ workflowEntity
    let seasonId = M.SS.seasonIdFromKey <$> seasonEntityId
    season <- sequence $ RP.SS.getById <$> seasonId

    let workflowModel = join $ M.WF.fromEntity
                                   workflowEntity
                                   <$> germplasms
                                   <*> sequence season

    return workflowModel

baseFilter :: [Filter WorkflowEntity]
baseFilter = [WorkflowEntityDeletedOn ==. Nothing]

