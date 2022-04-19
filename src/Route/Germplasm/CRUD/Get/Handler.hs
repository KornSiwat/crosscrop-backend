{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.CRUD.Get.Handler where

import           Import

import           Helper.TypeConverter

import qualified Model.Germplasm                            as M

import           Route.Common.Response
import           Route.Germplasm.CRUD.Get.Presenter.Factory

import qualified Usecase.Germplasm                          as UC

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasmIds <- lookupGetParam "ids"

    let germplasmIds' = map M.GermplasmId <$> (treadMaybe =<< germplasmIds:: Maybe [Int])

    germplasms <- maybe UC.getAllGermplasm UC.getGermplasmByIds germplasmIds'

    let presenter = makeGetGermplasmPresenter <$> germplasms

    sendResponse status200 presenter

getOneGermplasmR :: M.GermplasmId
                 -> Handler Value
getOneGermplasmR id = do
    germplasm <- UC.getGermplasmById id

    let presenter = makeGetOneGermplasmPresenter <$> germplasm

    sendResponse status200 presenter
