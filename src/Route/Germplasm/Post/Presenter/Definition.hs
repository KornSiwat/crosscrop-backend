{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Post.Presenter.Definition where

import           Import

import           Data.Aeson

import           Helper.ToJSONOptions

import           Model.Germplasm

newtype PostGermplasmPresenter = PostGermplasmPresenter {
    _germplasmId :: GermplasmId
} deriving (Show, Generic)

instance ToJSON PostGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions
