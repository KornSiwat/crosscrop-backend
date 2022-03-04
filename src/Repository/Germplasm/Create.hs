{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NamedFieldPuns         #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Repository.Germplasm.Create where

import           Class.ToPersistKey

import           UnliftIO.Exception              (catch)

import           Error.Definition

import           Import                          hiding (catch)

import qualified Model.Germplasm                 as M
import qualified Model.Workflow.Common.Attribute as M

import           Persist.Entity
import           Persist.Field.JsonB

createGermplasm :: M.GermplasmName -> Maybe M.WorkflowId -> M.Attributes -> Handler (Either Error M.GermplasmId)
createGermplasm name workflowId attributes = do
    currentTime <- liftIO getCurrentTime

    let (M.GermplasmName name') = name
    let workflowId' =  toKey <$> workflowId
    let attributes' = JsonB $ toJSON $ attributes
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = GermplasmEntity name' attributes' workflowId' createdOn updatedOn deletedOn

    key <- (Right <$> (runDB $ insert entity)) `catch` (\(SomeException _) -> return $ Left ToBeDefinedError)

    return $ M.germplasmIdFromKey <$> key
