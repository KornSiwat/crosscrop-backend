{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Germplasm.Create where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Germplasm    as M
import qualified Model.Workflow     as M

import           Persist.Entity

import           Repository.Common

createGermplasm :: M.GermplasmName
                -> Maybe M.WorkflowId
                -> [M.GermplasmAttribute]
                -> Handler (Either Error M.GermplasmId)
createGermplasm name workflowId attributes = do
    currentTime <- liftIO getCurrentTime

    let (M.GermplasmName name') = name
    let workflowId' =  toKey <$> workflowId
    let attributes' = map tshow attributes
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = GermplasmEntity name' attributes' workflowId' createdOn updatedOn deletedOn

    key <- runDB $ insert entity

    let germplasmId = M.germplasmIdFromKey <$> key

    return germplasmId
