{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.RemoveGermplasmAttribute.Presenter.Factory where

import           Import

import           Model.Coldroom

import           Route.Coldroom.Common.Presenter
import           Route.Coldroom.RemoveGermplasmAttribute.Presenter.Definition

makeColdroomRemoveGermplasmAttributePresenter :: Coldroom
                                              -> ColdroomRemoveGermplasmAttributePresenter
makeColdroomRemoveGermplasmAttributePresenter
    = ColdroomRemoveGermplasmAttributePresenter . fromColdroom
