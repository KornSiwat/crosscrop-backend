{-# LANGUAGE AllowAmbiguousTypes    #-}
{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}
{-# LANGUAGE TypeFamilies           #-}

module Route.Germplasm.Post.Handler where

import           Import                                 hiding (id)

import           Control.Lens

import           Error.Definition

import           Helper.Request

import           Model.Germplasm
import           Model.Workflow.Common.Attribute        (WorkflowId (..))

import qualified Repository.Germplasm.Create            as RP

import           Route.Germplasm.Post.Presenter.Factory
import qualified Route.Germplasm.Post.RequestBody       as RQ

postGermplasmR :: Handler Value
postGermplasmR = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PostGermplasmRequestBody)

    germplasmId <- join <$> (sequence $ liftM createGermplasm jsonBody)

    case makePostGermplasmPresenter <$> germplasmId of
        Right presenter -> sendResponseStatus status200 (toJSON presenter)
        Left error'     -> sendResponseStatus status500 (tshow $ error'::Text)

createGermplasm :: RQ.PostGermplasmRequestBody -> Handler (Either Error GermplasmId)
createGermplasm body =  do
    let name' = GermplasmName (body^.RQ.name)
    let workflowId' = WorkflowId <$> (body^.RQ.workflowId)
    let attributes' = attributesFromMapTextValue (body^.RQ.attributes)

    join <$> (sequence $ liftM (RP.createGermplasm name' workflowId') attributes')
