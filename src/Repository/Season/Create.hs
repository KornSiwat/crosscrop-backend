{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Season.Create where

import           Import

import           Error.Definition

import qualified Model.Season      as M

import           Persist.Entity

import           Repository.Common

createSeason :: M.Year
             -> M.SeasonNo
             -> Handler (Either Error M.SeasonId)
createSeason year seasonNo = do
    currentTime <- liftIO getCurrentTime

    let (M.Year year') = year
    let (M.SeasonNo seasonNo') = seasonNo
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = SeasonEntity year' seasonNo' createdOn updatedOn deletedOn

    key <- runDB $ insert entity

    let seasonId = M.seasonIdFromKey <$> key

    return seasonId
