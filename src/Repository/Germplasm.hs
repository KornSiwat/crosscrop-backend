{-# LANGUAGE OverloadedStrings #-}

module Repository.Germplasm where

import           Import

import           Control.Lens

import           Class.ToKey
import           Model.Germplasm.Common.Attribute
import           Model.Germplasm.Common.Definition
import           Model.Workflow.Common.Attribute
import           Persist.Entity
import           Persist.Field.JsonB

getGermplasms :: Handler [Germplasm]
getGermplasms = do
    germplasmEntity <- runDB $ selectList ([]:: [Filter GermplasmEntity]) []

    return []

createGermplasm :: Germplasm -> Maybe WorkflowId -> Handler (Key GermplasmEntity)
createGermplasm germplasm workflowId = do
    currentTime <- liftIO getCurrentTime

    let (GermplasmName name') = germplasm^.name
    let workflowId' =  toKey <$> workflowId
    let attributes' = JsonB $ toJSON $ germplasm^.attributes
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = GermplasmEntity name' attributes' workflowId' createdOn updatedOn deletedOn

    runDB $ insert entity
