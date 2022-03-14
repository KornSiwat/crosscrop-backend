{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Get.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.Common.Presenter
import           Route.Germplasm.Get.Presenter.Definition

makeGetGermplasmPresenter :: [Germplasm] -> GetGermplasmPresenter
makeGetGermplasmPresenter xs = GetGermplasmPresenter germplasmPresenters
    where
        germplasmPresenters = map fromGermplasm xs

makeGetOneGermplasmPresenter :: Germplasm -> GetOneGermplasmPresenter
makeGetOneGermplasmPresenter = GetOneGermplasmPresenter . fromGermplasm
