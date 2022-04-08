{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Germplasm.Post.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson
import qualified Data.HashMap.Lazy              as HM

import qualified Model.Germplasm                as M.Germplasm
import qualified Model.Workflow                 as M.Workflow

import           Route.Germplasm.Common.Request

data PostGermplasmRequestBody
    = PostGermplasmRequestBody
        { _name       :: M.Germplasm.GermplasmName
        , _workflowId :: Maybe M.Workflow.WorkflowId
        , _attributes :: M.Germplasm.Attributes
        }
    deriving (Show)

instance FromJSON PostGermplasmRequestBody where
    parseJSON = withObject "PostGermplasmRequestBody" parsePostGermplasmRequestBody
        where
        parsePostGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"
            let attributes = M.Germplasm.fromMapTextValue $ foldr HM.delete x germplasmMainAttributeNames

            case attributes of
                Right attributes' -> return $ PostGermplasmRequestBody name workflowId attributes'
                Left e -> error $ show e

makeFieldsNoPrefix ''PostGermplasmRequestBody
