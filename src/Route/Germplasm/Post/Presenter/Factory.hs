{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Post.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.Common.Presenter
import           Route.Germplasm.Post.Presenter.Definition

makePostGermplasmPresenter :: Germplasm
                           -> PostGermplasmPresenter
makePostGermplasmPresenter = PostGermplasmPresenter . fromGermplasm
