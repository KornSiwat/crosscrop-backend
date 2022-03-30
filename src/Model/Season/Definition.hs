{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Season.Definition where

import           Import

import           Control.Lens           (makeFieldsNoPrefix)

import           Model.Common.Attribute
import           Model.Season.Attribute

data Season =
    Season
        { _id       :: SeasonId
        , _year     :: Year
        , _seasonNo :: SeasonNo
        , _createdOn      :: CreatedOn
        , _updatedOn      :: Maybe UpdatedOn
        , _deletedOn      :: Maybe DeletedOn
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''Season

