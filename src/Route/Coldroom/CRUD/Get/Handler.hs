{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Coldroom.CRUD.Get.Handler where

import           Import

import           Route.Coldroom.CRUD.Get.Presenter.Factory
import           Route.Common.Response

import qualified Usecase.Coldroom                          as UC

getColdroomR :: Handler Value
getColdroomR = do
    coldroom <- UC.getColdroom

    let presenter = makeGetColdroomPresenter <$> coldroom

    sendResponse status200 presenter

