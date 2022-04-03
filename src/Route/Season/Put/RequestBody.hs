{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Season.Put.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Season as M

data PutSeasonRequestBody = PutSeasonRequestBody {
    _year     :: M.Year,
    _seasonNo :: M.SeasonNo
    } deriving (Show, Generic)

instance FromJSON PutSeasonRequestBody where
    parseJSON = withObject "PutSeasonRequestBody" parsePutSeasonRequestBody
        where
            parsePutSeasonRequestBody x = do
                year <- x .: "year"
                seasonNo <- x .: "season_no"

                return $ PutSeasonRequestBody year seasonNo

makeFieldsNoPrefix ''PutSeasonRequestBody

