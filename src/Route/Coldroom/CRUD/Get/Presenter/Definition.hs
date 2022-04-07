{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.CRUD.Get.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Coldroom.Common.ColdroomPresenter.Definition
import           Route.Common.JSONOptions

newtype GetColdroomPresenter = GetColdroomPresenter {
    _coldroom :: ColdroomPresenter
} deriving (Show, Generic)

instance ToJSON GetColdroomPresenter where
    toJSON = genericToJSON toJSONOptions

