{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Put.Handler where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm                       as M

import qualified Repository.Germplasm                  as Repository

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.Put.Presenter.Factory
import qualified Route.Germplasm.Put.RequestBody       as RQ

putOneGermplasmR :: M.GermplasmId -> Handler Value
putOneGermplasmR id = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PutGermplasmRequestBody)

    germplasm <- join <$> sequence (updateGermplasm id <$> jsonBody)

    let presenter = makePutGermplasmPresenter <$> germplasm

    sendResponse status200 presenter

updateGermplasm :: M.GermplasmId
                -> RQ.PutGermplasmRequestBody
                -> Handler (Either Error M.Germplasm)
updateGermplasm id body =  do
    let name = body^.RQ.name
    let attributes = body^.RQ.attributes

    existingGermplasm <- Repository.getById id

    let updateGermplasmArg = existingGermplasm
                                 <&> M.name .~ name
                                 <&> M.attributes .~ attributes

    updateResult <- join <$> sequence (Repository.updateOne <$> updateGermplasmArg)

    updatedGermplasm <- Repository.getById id

    return $ join (updateResult $> updatedGermplasm)

