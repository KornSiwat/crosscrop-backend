{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Get.Handler where

import           Import

import qualified Model.Germplasm                       as M

import           Route.Common.Response
import           Route.Germplasm.Get.Presenter.Factory

import qualified Usecase.Germplasm                     as UC

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasms <- UC.getAllGermplasm

    let presenter = makeGetGermplasmPresenter <$> germplasms

    sendResponse status200 presenter

getOneGermplasmR :: M.GermplasmId -> Handler Value
getOneGermplasmR id = do
    germplasm <- UC.getGermplasmById id

    let presenter = makeGetOneGermplasmPresenter <$> germplasm

    sendResponse status200 presenter

