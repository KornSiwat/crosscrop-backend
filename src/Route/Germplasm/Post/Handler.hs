{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Post.Handler where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm                        as M

import qualified Repository.Germplasm                   as RP

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.Post.Presenter.Factory
import qualified Route.Germplasm.Post.RequestBody       as RQ

postGermplasmR :: Handler Value
postGermplasmR = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PostGermplasmRequestBody)

    germplasmId <- join <$> sequence (createGermplasm <$> jsonBody)

    germplasm <- join <$> sequence (RP.getById <$> germplasmId)

    let presenter = makePostGermplasmPresenter <$> germplasm

    sendResponse status201 presenter

createGermplasm :: RQ.PostGermplasmRequestBody -> Handler (Either Error M.GermplasmId)
createGermplasm body =  do
    let name = body^.RQ.name
    let workflowId = body^.RQ.workflowId
    let attributes = body^.RQ.attributes

    RP.createGermplasm name workflowId attributes

