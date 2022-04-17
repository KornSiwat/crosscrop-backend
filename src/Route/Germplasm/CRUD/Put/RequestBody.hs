{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.CRUD.Put.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M.GP
import qualified Model.Workflow  as M.WF

data PutGermplasmRequestBody
    = PutGermplasmRequestBody
        { _name       :: M.GP.GermplasmName
        , _workflowId :: Maybe M.WF.WorkflowId
        , _attributes :: [M.GP.GermplasmAttribute]
        }
    deriving (Show)

instance FromJSON PutGermplasmRequestBody where
    parseJSON = withObject "PutGermplasmRequestBody" parsePutGermplasmRequestBody
        where
        parsePutGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"
            attributes <- x .: "attributes"

            return $ PutGermplasmRequestBody
                         name
                         workflowId
                         attributes

makeFieldsNoPrefix ''PutGermplasmRequestBody
