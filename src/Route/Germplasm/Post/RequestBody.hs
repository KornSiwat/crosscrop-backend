{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.Post.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Germplasm as M.GP
import qualified Model.Workflow  as M.WF

data PostGermplasmRequestBody
    = PostGermplasmRequestBody
        { _name       :: M.GP.GermplasmName
        , _workflowId :: Maybe M.WF.WorkflowId
        , _attributes :: [M.GP.GermplasmAttribute]
        }
    deriving (Show)

instance FromJSON PostGermplasmRequestBody where
    parseJSON = withObject "PostGermplasmRequestBody" parsePostGermplasmRequestBody
        where
        parsePostGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"
            attributes <- x .: "attributes"

            return $ PostGermplasmRequestBody
                         name
                         workflowId
                         attributes

makeFieldsNoPrefix ''PostGermplasmRequestBody
