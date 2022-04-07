{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasm.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Coldroom.Common.ColdroomPresenter.Definition
import           Route.Common.JSONOptions

newtype ColdroomAddGermplasmPresenter = ColdroomAddGermplasmPresenter {
    _coldroom :: ColdroomPresenter
} deriving (Show, Generic)

instance ToJSON ColdroomAddGermplasmPresenter where
    toJSON = genericToJSON toJSONOptions

