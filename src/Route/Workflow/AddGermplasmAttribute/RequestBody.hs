{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Workflow.AddGermplasmAttribute.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

data WorkflowAddGermplasmAttributeRequestBody
    = WorkflowAddGermplasmAttributeRequestBody
        { _name                   :: M.GermplasmAttributeName
        , _germplasmAttributeType :: M.GermplasmAttributeType
        }
    deriving (Show, Generic)

instance FromJSON WorkflowAddGermplasmAttributeRequestBody where
    parseJSON = withObject "WorkflowAddGermplasmAttributeRequestBody" parseWorkflowAddGermplasmAttributeRequestBody
        where
        parseWorkflowAddGermplasmAttributeRequestBody x = do
            name <- x .: "name"
            germplasmAttributeType <- x .: "type"

            return $ WorkflowAddGermplasmAttributeRequestBody
                         name
                         germplasmAttributeType

makeFieldsNoPrefix ''WorkflowAddGermplasmAttributeRequestBody
