{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Put.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Season.Common.Presenter

newtype PutSeasonPresenter = PutSeasonPresenter {
    _season :: SeasonPresenter
} deriving (Show, Generic)

instance ToJSON PutSeasonPresenter where
    toJSON = genericToJSON toJSONOptions

