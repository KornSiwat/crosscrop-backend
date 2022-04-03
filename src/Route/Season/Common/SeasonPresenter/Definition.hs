{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Common.SeasonPresenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.JSONOptions

import           Model.Common.Attribute
import           Model.Season

data SeasonPresenter = SeasonPresenter
    { _id        :: SeasonId
    , _year      :: Year
    , _seasonNo  :: SeasonNo
    , _createdOn :: CreatedOn
    , _updatedOn :: Maybe UpdatedOn
    } deriving (Show, Generic)

instance ToJSON SeasonPresenter where
    toJSON = genericToJSON toJSONOptions

