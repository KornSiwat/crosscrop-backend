{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.Common.Definition where

import           Import

import           Control.Lens                    (makeFieldsNoPrefix)

import           Model.Common.Attribute
import qualified Model.Germplasm                 as GP
import qualified Model.Season                    as SS
import           Model.Workflow.Common.Attribute

-- Workflow
data Workflow =
  Workflow
    { _id         :: WorkflowId
    , _name       :: WorkflowName
    , _germplasms :: [GP.Germplasm]
    , _season     :: Maybe SS.Season
    , _createdOn  :: CreatedOn
    , _updatedOn  :: Maybe UpdatedOn
    , _deletedOn  :: Maybe DeletedOn
    }
  deriving (Show, Eq)

makeFieldsNoPrefix ''Workflow
