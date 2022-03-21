{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Get.Handler where

import           Import

import qualified Model.Germplasm as M

import qualified Repository.Germplasm                  as Repository

import           Route.Common.Response
import           Route.Germplasm.Get.Presenter.Factory

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasms <- Repository.getAll

    let presenter = makeGetGermplasmPresenter <$> germplasms

    sendResponse status200 presenter

getOneGermplasmR :: M.GermplasmId -> Handler Value
getOneGermplasmR id = do
    germplasm <- Repository.getOne id

    let presenter = makeGetOneGermplasmPresenter <$> germplasm

    sendResponse status200 presenter

