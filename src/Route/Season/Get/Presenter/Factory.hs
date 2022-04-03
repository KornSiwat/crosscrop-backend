{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Get.Presenter.Factory where

import           Import

import           Model.Season

import           Route.Season.Common.Presenter
import           Route.Season.Get.Presenter.Definition

makeGetOneSeasonPresenter :: Season -> GetOneSeasonPresenter
makeGetOneSeasonPresenter = GetOneSeasonPresenter . fromSeason

