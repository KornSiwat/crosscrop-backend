{-# LANGUAGE NoImplicitPrelude     #-}

module Route.Season.Post.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import           Route.Common.Request
import           Route.Common.Response
import           Route.Season.Post.Presenter.Factory
import           Route.Season.Post.RequestBody

import qualified Usecase.Season                      as UC

postSeasonR :: Handler Value
postSeasonR = do
    body <- parseJSONBody :: Handler (Either Error PostSeasonRequestBody)

    season <- join <$> sequence
                    (UC.createSeason
                        <$> body&^.year
                        <*> body&^.seasonNo)

    let presenter = makePostSeasonPresenter <$> season

    sendResponse status201 presenter
