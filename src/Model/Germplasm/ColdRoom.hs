{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.ColdRoom where

import           Prelude                           hiding (id)

import           Control.Lens                      (makeFieldsNoPrefix)
import           Data.Map                          (empty)

import           Error.Definition                  (Error)

import           Helper.Validator                  (isValid)

import           Model.Germplasm.Common.Attribute  (Attributes,
                                                    GermplasmCount (GermplasmCount),
                                                    GermplasmId (GermplasmId),
                                                    GermplasmName (GermplasmName))
import           Model.Germplasm.Common.Definition (Germplasm)

-- ColdRoom Germplasm
data ColdRoomGermplasm =
    ColdRoomGermplasm
        { _germplasm :: Germplasm
        , _count     :: GermplasmCount
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''ColdRoomGermplasm

makeColdRoomGermplasm :: Germplasm -> GermplasmCount -> ColdRoomGermplasm
makeColdRoomGermplasm x y = ColdRoomGermplasm {_germplasm = x, _count = y}
