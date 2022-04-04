{-# LANGUAGE NoImplicitPrelude #-}

module Route.Season.Get.Handler where

import           Import

import qualified Model.Season                       as M

import           Route.Common.Response
import           Route.Season.Get.Presenter.Factory

import qualified Usecase.Season                     as UC

getOneSeasonR :: M.SeasonId -> Handler Value
getOneSeasonR id = do
    season <- UC.getSeasonById id

    let presenter = makeGetOneSeasonPresenter <$> season

    sendResponse status200 presenter

