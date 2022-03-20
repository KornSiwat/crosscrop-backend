{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.Common.Definition where

import           Import

import           Control.Lens                     (makeFieldsNoPrefix)

import           Model.Germplasm.Common.Attribute

-- Germplasm
data Germplasm =
  Germplasm
    { _id         :: GermplasmId
    , _name       :: GermplasmName
    , _attributes :: Attributes
    , _createdOn  :: CreatedOn
    , _updatedOn  :: Maybe UpdatedOn
    , _deletedOn  :: Maybe DeletedOn
    }
  deriving (Show, Eq)

makeFieldsNoPrefix ''Germplasm

