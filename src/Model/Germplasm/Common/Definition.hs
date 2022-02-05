{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.Common.Definition where

import           Prelude                          hiding (id)

import           Control.Lens                     (makeFields)

import           Model.Germplasm.Common.Attribute

-- Germplasm
data Germplasm =
  Germplasm
    { _germplasmId         :: GermplasmId
    , _germplasmName       :: GermplasmName
    , _germplasmAttributes :: Attributes
    }
  deriving (Show, Eq)

makeFields ''Germplasm
