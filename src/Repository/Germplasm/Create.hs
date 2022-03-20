{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}

module Repository.Germplasm.Create where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Germplasm                 as M
import qualified Model.Workflow.Common.Attribute as M

import           Persist.Entity
import           Persist.Field.JsonB

import           UnliftIO.Exception              (catch)

createGermplasm :: M.GermplasmName
                    -> Maybe M.WorkflowId
                    -> M.Attributes
                    -> Handler (Either Error M.GermplasmId)
createGermplasm name workflowId attributes = do
    currentTime <- liftIO getCurrentTime

    let (M.GermplasmName name') = name
    let workflowId' =  toKey <$> workflowId
    let attributes' = JsonB $ toJSON attributes
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = GermplasmEntity name' attributes' workflowId' createdOn updatedOn deletedOn

    key <- (Right <$> runDB (insert entity)) `catch` (\(SomeException _) -> return $ Left ToBeDefinedError)

    return $ M.germplasmIdFromKey <$> key
