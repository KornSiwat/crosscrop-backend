{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.CRUD.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions
import           Route.Germplasm.Common.Presenter

newtype PostGermplasmPresenter
    = PostGermplasmPresenter
        { _germplasm :: GermplasmPresenter
        }
    deriving (Show, Generic)

instance ToJSON PostGermplasmPresenter where
    toJSON = genericToJSON toJSONOptions