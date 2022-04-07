{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasm.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import           Route.Coldroom.AddGermplasm.Presenter.Factory
import           Route.Coldroom.AddGermplasm.RequestBody
import           Route.Common.Request
import           Route.Common.Response

import qualified Usecase.Coldroom                              as UC.CR
import qualified Usecase.Germplasm                             as UC.GP

postColdroomAddGermplasmR :: Handler Value
postColdroomAddGermplasmR = do
    body <- parseJSONBody :: Handler (Either Error ColdroomAddGermplasmRequestBody)

    germplasms <- join <$> sequence (UC.GP.getGermplasmByIds <$> body&^.germplasmIds)
    coldroom <- join <$> sequence
                     (UC.CR.addGermplasms <$> germplasms)

    let presenter = makeColdroomAddGermplasmPresenter <$> coldroom

    sendResponse status200 presenter

