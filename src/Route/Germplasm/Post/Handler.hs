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

import           Helper.Request
import           Helper.Response

import           Model.Germplasm
import           Model.Workflow.Common.Attribute

import qualified Repository.Germplasm.Create            as RP

import           Route.Germplasm.Post.Presenter.Factory
import qualified Route.Germplasm.Post.RequestBody       as RQ

postGermplasmR :: Handler Value
postGermplasmR = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PostGermplasmRequestBody)

    germplasmId <- join <$> sequence (createGermplasm <$> jsonBody)

    let presenter = makePostGermplasmPresenter <$> germplasmId

    sendResponse status201 presenter

createGermplasm :: RQ.PostGermplasmRequestBody -> Handler (Either Error GermplasmId)
createGermplasm body =  do
    let name' = GermplasmName $ body^.RQ.name
    let workflowId' = WorkflowId <$> body^.RQ.workflowId
    let attributes' = attributesFromMapTextValue $ body^.RQ.attributes

    join <$> sequence (RP.createGermplasm name' workflowId' <$> attributes')
