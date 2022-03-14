{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Get.Handler where

import           Import

import qualified Repository.Germplasm                  as Repository

import           Route.Common.Response
import           Route.Germplasm.Get.Presenter.Factory

import           Persist.Entity

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasms <- Repository.getAll

    let presenter = makeGetGermplasmPresenter <$> germplasms

    sendResponse status200 presenter

getOneGermplasmR :: GermplasmEntityId -> Handler Value
getOneGermplasmR id = do
    germplasm <- Repository.getOne id

    let presenter = makeGetOneGermplasmPresenter <$> germplasm

    sendResponse status200 presenter
