{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Model.Season

import           Route.Common.JSONOptions

newtype PostSeasonPresenter = PostSeasonPresenter {
    _seasonId :: SeasonId
} deriving (Show, Generic)

instance ToJSON PostSeasonPresenter where
    toJSON = genericToJSON toJSONOptions

