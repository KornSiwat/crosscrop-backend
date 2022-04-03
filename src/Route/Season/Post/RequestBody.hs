{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Route.Season.Post.RequestBody where

import           Import

import           Control.Lens

import           Data.Aeson

import qualified Model.Season as M

data PostSeasonRequestBody = PostSeasonRequestBody {
    _year     :: M.Year,
    _seasonNo :: M.SeasonNo
    } deriving (Show, Generic)

instance FromJSON PostSeasonRequestBody where
    parseJSON = withObject "PostSeasonRequestBody" parsePostSeasonRequestBody
        where
        parsePostSeasonRequestBody x = do
            year <- x .: "year"
            seasonNo <- x .: "season_no"

            return $ PostSeasonRequestBody year seasonNo

makeFieldsNoPrefix ''PostSeasonRequestBody

