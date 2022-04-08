{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Post.Presenter.Factory where

import           Model.Season

import           Route.Season.Common.Presenter
import           Route.Season.Post.Presenter.Definition

makePostSeasonPresenter :: Season
                        -> PostSeasonPresenter
makePostSeasonPresenter = fromSeason
