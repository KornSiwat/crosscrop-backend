{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.CrossingBlock where

import           Prelude                           hiding (id)

import           Control.Lens                      (makeFieldsNoPrefix)
import           Data.Map                          (empty)

import           Error.Definition                  (Error)

import           Helper.Validator                  (isValid)

import           Model.Germplasm.Common.Attribute  (Attributes,
                                                    GermplasmId (GermplasmId),
                                                    GermplasmName (GermplasmName))
import           Model.Germplasm.Common.Definition (FemaleGermplasm, Germplasm,
                                                    MaleGermplasm)

-- CrossingBlock Germplasm
data CrossingBlockGermplasm =
    CrossingBlockGermplasm
        { _germplasm       :: Germplasm
        , _femaleGermplasm :: FemaleGermplasm
        , _maleGermplasm   :: MaleGermplasm
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''CrossingBlockGermplasm

makeCrossingBlockGermplasm :: Germplasm -> FemaleGermplasm -> MaleGermplasm -> CrossingBlockGermplasm
makeCrossingBlockGermplasm x y z = CrossingBlockGermplasm {_germplasm = x, _femaleGermplasm = y, _maleGermplasm = z}
