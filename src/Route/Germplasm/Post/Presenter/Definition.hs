{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Post.Presenter.Definition where

import           Data.Aeson

import           Import               hiding (id)

import           Helper.ToJSONOptions

import           Model.Germplasm

newtype PostGermplasmPresenter = PostGermplasmPresenter {
    _germplasmId :: GermplasmId
} deriving (Show, Generic)

instance ToJSON PostGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions
