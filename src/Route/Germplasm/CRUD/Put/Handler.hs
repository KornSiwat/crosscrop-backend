{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.CRUD.Put.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Germplasm                            as M

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.CRUD.Put.Presenter.Factory
import           Route.Germplasm.CRUD.Put.RequestBody

import qualified Usecase.Germplasm                          as UC

putOneGermplasmR :: M.GermplasmId
                 -> Handler Value
putOneGermplasmR id = do
    body <- parseJSONBody :: Handler (Either Error PutGermplasmRequestBody)

    germplasm <- join <$> sequence
                     (UC.updateGermplasm
                             id
                         <$> body&^.name
                         <*> body&^.attributes)

    let presenter = makePutGermplasmPresenter <$> germplasm

    sendResponse status200 presenter

