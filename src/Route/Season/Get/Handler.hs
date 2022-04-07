{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Season.Get.Handler where

import           Import

import           Helper.TypeConverter

import qualified Model.Season                       as M

import           Route.Common.Response
import           Route.Season.Get.Presenter.Factory

import qualified Usecase.Season                     as UC

getSeasonR :: Handler Value
getSeasonR = do
    year <- lookupGetParam "year"
    seasonNo <- lookupGetParam "season-no"

    let year' = M.Year <$> (treadMaybe =<< year:: Maybe Int)
    let seasonNo' = M.SeasonNo <$> (treadMaybe =<< seasonNo:: Maybe Int)

    seasons <- case (year', seasonNo') of
                      (Just x, Just y)    -> UC.getSeasonsByYearAndSeasonNo x y
                      (Just x, Nothing)   -> UC.getSeasonsByYear x
                      (Nothing, Just y)   -> UC.getSeasonsBySeasonNo y
                      (Nothing,  Nothing) -> UC.getAllSeason

    let presenter = makeGetSeasonPresenter <$> seasons

    sendResponse status200 presenter

getOneSeasonR :: M.SeasonId -> Handler Value
getOneSeasonR id = do
    season <- UC.getSeasonById id

    let presenter = makeGetOneSeasonPresenter <$> season

    sendResponse status200 presenter

