{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Post.Presenter.Factory where

import           Model.Season

import           Route.Season.Post.Presenter.Definition

makePostSeasonPresenter :: SeasonId -> PostSeasonPresenter
makePostSeasonPresenter = PostSeasonPresenter

