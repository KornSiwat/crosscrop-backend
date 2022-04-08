{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Put.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Germplasm.Common.Presenter

newtype PutGermplasmPresenter
    = PutGermplasmPresenter
        { _germplasm :: GermplasmPresenter
        }
    deriving (Show, Generic)

instance ToJSON PutGermplasmPresenter where
    toJSON = genericToJSON toJSONOptions
