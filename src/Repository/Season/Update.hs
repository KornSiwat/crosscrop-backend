{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Season.Update where

import           Import

import           Class.ToPersistKey

import           Control.Lens

import           Error.Definition

import qualified Model.Season       as M

import           Persist.Entity

import           Repository.Common

updateOne :: M.Season
          -> Handler (Either Error ())
updateOne season = do
    currentTime <- liftIO getCurrentTime

    let id = toKey $ season^.M.id
    let (M.Year year) = season^.M.year
    let (M.SeasonNo seasonNo) = season^.M.seasonNo
    let updatedOn = Just currentTime

    runDB $ update
                id
                [SeasonEntityYear =. year
                ,SeasonEntitySeasonNo =. seasonNo
                ,SeasonEntityUpdatedOn =. updatedOn
                ]

