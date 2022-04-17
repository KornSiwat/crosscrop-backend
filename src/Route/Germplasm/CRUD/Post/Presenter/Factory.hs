{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.CRUD.Post.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.CRUD.Post.Presenter.Definition
import           Route.Germplasm.Common.Presenter

makePostGermplasmPresenter :: Germplasm
                           -> PostGermplasmPresenter
makePostGermplasmPresenter = PostGermplasmPresenter . fromGermplasm
