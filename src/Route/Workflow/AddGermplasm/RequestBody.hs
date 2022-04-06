{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Workflow.AddGermplasm.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

newtype WorkflowAddGermplasmRequestBody = WorkflowAddGermplasmRequestBody {
    _germplasmIds :: [M.GermplasmId]
    } deriving (Show, Generic)

instance FromJSON WorkflowAddGermplasmRequestBody where
    parseJSON = withObject "WorkflowAddGermplasmRequestBody" parseWorkflowAddGermplasmRequestBody
        where
        parseWorkflowAddGermplasmRequestBody x = do
            germplasmIds <- x .: "germplasm_ids"

            return $ WorkflowAddGermplasmRequestBody germplasmIds

makeFieldsNoPrefix ''WorkflowAddGermplasmRequestBody

