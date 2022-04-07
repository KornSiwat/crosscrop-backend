{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.CRUD.Get.Presenter.Factory where

import           Import

import           Model.Coldroom

import           Route.Coldroom.CRUD.Get.Presenter.Definition
import           Route.Coldroom.Common.Presenter

makeGetColdroomPresenter :: Coldroom -> GetColdroomPresenter
makeGetColdroomPresenter = GetColdroomPresenter . fromColdroom

