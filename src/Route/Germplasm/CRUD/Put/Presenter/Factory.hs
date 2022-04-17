{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.CRUD.Put.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.CRUD.Put.Presenter.Definition
import           Route.Germplasm.Common.Presenter

makePutGermplasmPresenter :: Germplasm
                          -> PutGermplasmPresenter
makePutGermplasmPresenter = PutGermplasmPresenter . fromGermplasm
