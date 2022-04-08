{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Put.Presenter.Factory where

import           Import

import           Model.Season

import           Route.Season.Common.Presenter
import           Route.Season.Put.Presenter.Definition

makePutSeasonPresenter :: Season
                       -> PutSeasonPresenter
makePutSeasonPresenter = PutSeasonPresenter . fromSeason
