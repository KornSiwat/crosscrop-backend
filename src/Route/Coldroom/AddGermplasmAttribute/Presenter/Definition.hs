{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasmAttribute.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Coldroom.Common.ColdroomPresenter.Definition
import           Route.Common.JSONOptions

newtype ColdroomAddGermplasmAttributePresenter
    = ColdroomAddGermplasmAttributePresenter
        { _coldroom :: ColdroomPresenter
        }
    deriving (Show, Generic)

instance ToJSON ColdroomAddGermplasmAttributePresenter where
    toJSON = genericToJSON toJSONOptions
