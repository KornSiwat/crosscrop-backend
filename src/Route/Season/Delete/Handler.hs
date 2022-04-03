{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Season.Delete.Handler where

import           Import

import qualified Model.Season        as M

import qualified Repository.Season   as RP

import           Route.Common.Response

deleteOneSeasonR :: M.SeasonId -> Handler Value
deleteOneSeasonR id = do
    deleteResult <- RP.deleteOne id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

