{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.Common.Definition where

import           Prelude                          hiding (id)

import           Control.Lens                     (makeFieldsNoPrefix)

import           Model.Germplasm.Common.Attribute

-- Germplasm
data Germplasm =
  Germplasm
    { _id         :: GermplasmId
    , _name       :: GermplasmName
    , _attributes :: Attributes
    }
  deriving (Show, Eq)

makeFieldsNoPrefix ''Germplasm
