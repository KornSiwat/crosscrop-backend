{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}

module Route.Season.Delete.Handler where

import           Import

import qualified Model.Season          as M

import           Route.Common.Response

import qualified Usecase.Season        as UC

deleteOneSeasonR :: M.SeasonId -> Handler Value
deleteOneSeasonR id = do
    deleteResult <- UC.deleteSeasonById id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

