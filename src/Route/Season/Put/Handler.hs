{-# LANGUAGE NoImplicitPrelude     #-}

module Route.Season.Put.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Season                       as M

import           Route.Common.Request
import           Route.Common.Response
import           Route.Season.Put.Presenter.Factory
import           Route.Season.Put.RequestBody

import qualified Usecase.Season                     as UC

putOneSeasonR :: M.SeasonId -> Handler Value
putOneSeasonR id = do
    body <- parseJSONBody :: Handler (Either Error PutSeasonRequestBody)

    season <- join <$> sequence
                     (UC.updateSeason
                             id
                         <$> body&^.year
                         <*> body&^.seasonNo)

    let presenter = makePutSeasonPresenter <$> season

    sendResponse status200 presenter

