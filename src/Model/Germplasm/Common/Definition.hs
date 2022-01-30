{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.Common.Definition where

import           Prelude                          hiding (id)

import           Control.Lens                     (makeFieldsNoPrefix)

import           Error.Definition                 (Error)

import           Model.Germplasm.Common.Attribute

-- Germplasm
data Germplasm =
  Germplasm
    { _germplasmId :: GermplasmId
    , _name        :: GermplasmName
    , _attributes  :: Attributes
    }
  deriving (Show, Eq)

makeFieldsNoPrefix ''Germplasm

makeGermplasm ::
     GermplasmId -> GermplasmName -> Attributes -> Either Error Germplasm
makeGermplasm x y zs = Right Germplasm {_germplasmId = x, _name = y, _attributes = zs}

-- Female Germplasm
newtype FemaleGermplasm =
  FemaleGermplasm Germplasm
  deriving (Show, Eq)

makeFemaleGermplasm :: Germplasm -> FemaleGermplasm
makeFemaleGermplasm = FemaleGermplasm

-- Male Germplasm
newtype MaleGermplasm =
  MaleGermplasm Germplasm
  deriving (Show, Eq)

makeMaleGermplasm :: Germplasm -> MaleGermplasm
makeMaleGermplasm = MaleGermplasm
