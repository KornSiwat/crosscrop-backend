{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Post.Handler where

import           Import

import           Class.ToPersistKey
import           Control.Lens

import           Error.Definition

import           Model.Germplasm
import           Model.Workflow.Common.Attribute

import qualified Repository.Germplasm                   as Repository

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.Post.Presenter.Factory
import qualified Route.Germplasm.Post.RequestBody       as Request

postGermplasmR :: Handler Value
postGermplasmR = do
    jsonBody <- parseJSONBody :: Handler (Either Error Request.PostGermplasmRequestBody)

    germplasmId <- join <$> sequence (createGermplasm <$> jsonBody)

    germplasm <- join <$> sequence (Repository.getOne . toKey <$> germplasmId)

    let presenter = makePostGermplasmPresenter <$> germplasm

    sendResponse status201 presenter

createGermplasm :: Request.PostGermplasmRequestBody -> Handler (Either Error GermplasmId)
createGermplasm body =  do
    let name' = GermplasmName $ body^.Request.name
    let workflowId' = WorkflowId <$> body^.Request.workflowId
    let attributes' = attributesFromMapTextValue $ body^.Request.attributes

    join <$> sequence (Repository.createGermplasm name' workflowId' <$> attributes')

