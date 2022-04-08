{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.Common.ColdroomPresenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions

import           Route.Germplasm.Common.Presenter

newtype ColdroomPresenter
    = ColdroomPresenter
        { _germplasms :: [GermplasmPresenter]
        }
    deriving (Show, Generic)

instance ToJSON ColdroomPresenter where
    toJSON = genericToJSON toJSONOptions
