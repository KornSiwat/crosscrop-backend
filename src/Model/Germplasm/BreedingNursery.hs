{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.BreedingNursery where

import           Prelude                           hiding (id)

import           Control.Lens                      (makeFieldsNoPrefix)
import           Data.Map                          (empty)

import           Error.Definition                  (Error)

import           Helper.Validator                  (isValid)

import           Model.Germplasm.Common.Attribute  (Plot)
import           Model.Germplasm.Common.Definition (Germplasm)

-- BreedingNursery Germplasm
data BreedingNurseryGermplasm =
    BreedingNurseryGermplasm
        { _germplasm :: Germplasm
        , _plot      :: Plot
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''BreedingNurseryGermplasm

makeBreedingNurseryGermplasm :: Germplasm -> Plot -> BreedingNurseryGermplasm
makeBreedingNurseryGermplasm x y = BreedingNurseryGermplasm {_germplasm = x, _plot = y}
