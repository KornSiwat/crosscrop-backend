{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasmAttribute.Presenter.Factory where

import           Import

import           Model.Coldroom

import           Route.Coldroom.AddGermplasmAttribute.Presenter.Definition
import           Route.Coldroom.Common.Presenter

makeColdroomAddGermplasmAttributePresenter :: Coldroom
                                           -> ColdroomAddGermplasmAttributePresenter
makeColdroomAddGermplasmAttributePresenter
    = ColdroomAddGermplasmAttributePresenter . fromColdroom
