{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Common.GermplasmPresenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.ToJSONOptions

data GermplasmPresenter = GermplasmPresenter
    { _id         :: Int
    , _name       :: Text
    , _attributes :: HashMap Text Value
    } deriving (Show, Generic)

instance ToJSON GermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions

