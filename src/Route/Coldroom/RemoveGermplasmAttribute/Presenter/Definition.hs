{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.RemoveGermplasmAttribute.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Coldroom.Common.ColdroomPresenter.Definition
import           Route.Common.JSONOptions

newtype ColdroomRemoveGermplasmAttributePresenter
    = ColdroomRemoveGermplasmAttributePresenter
        { _coldroom :: ColdroomPresenter
        }
    deriving (Show, Generic)

instance ToJSON ColdroomRemoveGermplasmAttributePresenter where
    toJSON = genericToJSON toJSONOptions
