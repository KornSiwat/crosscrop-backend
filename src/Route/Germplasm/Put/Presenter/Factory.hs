{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Put.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.Common.Presenter
import           Route.Germplasm.Put.Presenter.Definition

makePutGermplasmPresenter :: Germplasm -> PutGermplasmPresenter
makePutGermplasmPresenter = PutGermplasmPresenter . fromGermplasm

