{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Get.Presenter.Definition where

import           Data.Aeson
import           Import               hiding (id)

import           Helper.ToJSONOptions

newtype GetGermplasmPresenter = GetGermplasmPresenter {
    _germplasms :: [GermplasmPresenter]
} deriving (Show, Generic)

instance ToJSON GetGermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions

data GermplasmPresenter = GermplasmPresenter
    { _id         :: Int
    , _name       :: Text
    , _attributes :: HashMap Text Value
    } deriving (Show, Generic)

instance ToJSON GermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions
