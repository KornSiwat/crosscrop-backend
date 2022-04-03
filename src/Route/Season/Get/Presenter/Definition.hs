{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Get.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Season.Common.Presenter

newtype GetOneSeasonPresenter = GetOneSeasonPresenter {
    _season :: SeasonPresenter
} deriving (Show, Generic)

instance ToJSON GetOneSeasonPresenter where
    toJSON = genericToJSON toJSONOptions

