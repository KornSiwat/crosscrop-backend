{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Get.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.ToJSONOptions

import           Route.Germplasm.Common.Presenter

newtype GetGermplasmPresenter = GetGermplasmPresenter {
    _germplasms :: [GermplasmPresenter]
} deriving (Show, Generic)

instance ToJSON GetGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions

newtype GetOneGermplasmPresenter = GetOneGermplasmPresenter {
    _germplasm :: GermplasmPresenter
} deriving (Show, Generic)

instance ToJSON GetOneGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions
