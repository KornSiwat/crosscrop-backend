{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasm.Presenter.Factory where

import           Import

import           Model.Coldroom

import           Route.Coldroom.AddGermplasm.Presenter.Definition
import           Route.Coldroom.Common.Presenter

makeColdroomAddGermplasmPresenter :: Coldroom
                                  -> ColdroomAddGermplasmPresenter
makeColdroomAddGermplasmPresenter = ColdroomAddGermplasmPresenter . fromColdroom
