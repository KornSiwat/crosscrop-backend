{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Get.Handler where

import           Import

import           Helper.Response

import           Repository.Germplasm.Read

import           Route.Germplasm.Get.Presenter.Factory

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasms <- getGermplasms

    let presenter = makeGetGermplasmPresenter <$> germplasms

    sendResponse status200 presenter
