{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Post.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.Post.Presenter.Factory
import           Route.Germplasm.Post.RequestBody

import qualified Usecase.Germplasm                      as UC

postGermplasmR :: Handler Value
postGermplasmR = do
    body <- parseJSONBody :: Handler (Either Error PostGermplasmRequestBody)

    germplasm <- join <$> sequence
                     (UC.createGermplasm
                         <$> body&^.name
                         <*> body&^.workflowId
                         <*> body&^.attributes)

    let presenter = makePostGermplasmPresenter <$> germplasm

    sendResponse status201 presenter

