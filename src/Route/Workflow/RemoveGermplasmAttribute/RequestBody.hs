{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Workflow.RemoveGermplasmAttribute.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M

newtype WorkflowRemoveGermplasmAttributeRequestBody
    = WorkflowRemoveGermplasmAttributeRequestBody
        { _name                   :: M.GermplasmAttributeName
        }
    deriving (Show, Generic)

instance FromJSON WorkflowRemoveGermplasmAttributeRequestBody where
    parseJSON = withObject "WorkflowRemoveGermplasmAttributeRequestBody" parseWorkflowRemoveGermplasmAttributeRequestBody
        where
        parseWorkflowRemoveGermplasmAttributeRequestBody x = do
            name <- x .: "name"

            return $ WorkflowRemoveGermplasmAttributeRequestBody name

makeFieldsNoPrefix ''WorkflowRemoveGermplasmAttributeRequestBody
