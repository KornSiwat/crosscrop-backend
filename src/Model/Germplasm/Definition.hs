{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.Definition where

import           Import

import           Control.Lens                       (makeFieldsNoPrefix)

import           Model.Common.Attribute
import           Model.Germplasm.Attribute
import           Model.Germplasm.GermplasmAttribute

-- Germplasm
data Germplasm
    = Germplasm
        { _id         :: GermplasmId
        , _name       :: GermplasmName
        , _attributes :: [GermplasmAttribute]
        , _createdOn  :: CreatedOn
        , _updatedOn  :: Maybe UpdatedOn
        , _deletedOn  :: Maybe DeletedOn
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''Germplasm
