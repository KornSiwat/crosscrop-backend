{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Season.Post.Handler where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Season                        as M

import qualified Repository.Season                   as RP

import           Route.Common.Request
import           Route.Common.Response
import           Route.Season.Post.Presenter.Factory
import qualified Route.Season.Post.RequestBody       as RQ

postSeasonR :: Handler Value
postSeasonR = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PostSeasonRequestBody)

    seasonId <- join <$> sequence (createSeason <$> jsonBody)

    let presenter = makePostSeasonPresenter <$> seasonId

    sendResponse status201 presenter

createSeason :: RQ.PostSeasonRequestBody -> Handler (Either Error M.SeasonId)
createSeason body =  do
    let year = body^.RQ.year
    let seasonNo = body^.RQ.seasonNo

    let seasonId = RP.createSeason year seasonNo

    seasonId

