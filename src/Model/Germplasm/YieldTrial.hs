{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Germplasm.YieldTrial where

import           Prelude                           hiding (id)

import           Control.Lens                      (makeFieldsNoPrefix)
import           Data.Map                          (empty)

import           Error.Definition                  (Error)

import           Helper.Validator                  (isValid)

import           Model.Germplasm.Common.Attribute  (Attributes,
                                                    GermplasmId (GermplasmId),
                                                    GermplasmName (GermplasmName),
                                                    Plot (Plot))
import           Model.Germplasm.Common.Definition (Germplasm)

-- YieldTrial Germplasm
data YieldTrialGermplasm =
    YieldTrialGermplasm
        { _germplasm :: Germplasm
        , _plot      :: Plot
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''YieldTrialGermplasm

makeYieldTrialGermplasm :: Germplasm -> Plot -> YieldTrialGermplasm
makeYieldTrialGermplasm x y = YieldTrialGermplasm {_germplasm = x, _plot = y}
