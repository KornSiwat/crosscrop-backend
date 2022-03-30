{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Workflow.Update where

import           Import

import           Class.ToPersistKey

import           Control.Lens

import           Error.Definition

import qualified Model.Workflow     as M

import           Persist.Entity

import           Repository.Common

updateOne :: M.Workflow -> Handler (Either Error ())
updateOne workflow = do
    currentTime <- liftIO getCurrentTime

    let id = toKey $ workflow^.M.id
    let (M.WorkflowName name) = workflow^.M.name
    let updatedOn = Just currentTime

    runDB $ update
                id
                [WorkflowEntityName =. name
                ,WorkflowEntityUpdatedOn =. updatedOn]

