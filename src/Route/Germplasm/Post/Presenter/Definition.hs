{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.ToJSONOptions
import           Route.Germplasm.Common.Presenter

newtype PostGermplasmPresenter = PostGermplasmPresenter {
    _germplasm :: GermplasmPresenter
} deriving (Show, Generic)

instance ToJSON PostGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions
