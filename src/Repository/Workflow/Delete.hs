{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Workflow.Delete where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Workflow     as M

import           Persist.Entity

import           Repository.Common

deleteOne :: M.WorkflowId
          -> Handler (Either Error ())
deleteOne id = do
    currentTime <- liftIO getCurrentTime

    let id' = toKey id
    let deletedOn = Just currentTime

    runDB $ update
                id'
                [WorkflowEntityDeletedOn =. deletedOn]

