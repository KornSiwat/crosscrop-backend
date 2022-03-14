{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Common.GermplasmPresenter.Factory where

import           Import

import           Class.ToJSONKeyText
import           Class.ToValue

import           Control.Lens

import qualified Data.HashMap.Lazy                                    as HM

import qualified Model.Germplasm                                      as M

import           Route.Germplasm.Common.GermplasmPresenter.Definition

fromGermplasm :: M.Germplasm -> GermplasmPresenter
fromGermplasm x = GermplasmPresenter {
    _id = id',
    _name = name',
    _attributes = attributes'
} where
    M.GermplasmId id' = x^. M.id
    M.GermplasmName name' = x^. M.name
    attributes' = fromAttributes (x^. M.attributes)

fromAttributes :: M.Attributes -> HashMap Text Value
fromAttributes = valueToValue . keyToText
    where
        keyToText = HM.mapKeys toJSONKeyText
        valueToValue = HM.map toValue
