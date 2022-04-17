{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.CRUD.Get.Presenter.Factory where

import           Import

import           Model.Germplasm

import           Route.Germplasm.CRUD.Get.Presenter.Definition
import           Route.Germplasm.Common.Presenter

makeGetGermplasmPresenter :: [Germplasm]
                          -> GetGermplasmPresenter
makeGetGermplasmPresenter xs = GetGermplasmPresenter germplasmPresenters
    where
        germplasmPresenters = map fromGermplasm xs

makeGetOneGermplasmPresenter :: Germplasm
                             -> GetOneGermplasmPresenter
makeGetOneGermplasmPresenter = GetOneGermplasmPresenter . fromGermplasm
