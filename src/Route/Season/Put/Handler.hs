{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Season.Put.Handler where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Season                       as M

import qualified Repository.Season                  as RP.Season

import           Route.Common.Request
import           Route.Common.Response
import           Route.Season.Put.Presenter.Factory
import qualified Route.Season.Put.RequestBody       as RQ

putOneSeasonR :: M.SeasonId -> Handler Value
putOneSeasonR id = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PutSeasonRequestBody)

    germplasm <- join <$> sequence (updateSeason id <$> jsonBody)

    let presenter = makePutSeasonPresenter <$> germplasm

    sendResponse status200 presenter

updateSeason :: M.SeasonId -> RQ.PutSeasonRequestBody -> Handler (Either Error M.Season)
updateSeason id body =  do
    let year = body^.RQ.year
    let seasonNo = body^.RQ.seasonNo

    existingSeason <- RP.Season.getById id

    let updateSeasonArg = existingSeason
                              <&> M.year .~ year
                              <&> M.seasonNo .~ seasonNo

    updateResult <- sequence (RP.Season.updateOne <$> updateSeasonArg)

    updatedSeason <- RP.Season.getById id

    return $ join (updateResult $> updatedSeason)

