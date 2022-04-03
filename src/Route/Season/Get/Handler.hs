{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Season.Get.Handler where

import           Import

import qualified Model.Season                       as M

import qualified Repository.Season                  as Repository

import           Route.Common.Response
import           Route.Season.Get.Presenter.Factory

getOneSeasonR :: M.SeasonId -> Handler Value
getOneSeasonR id = do
    season <- Repository.getById id

    let presenter = makeGetOneSeasonPresenter <$> season

    sendResponse status200 presenter

