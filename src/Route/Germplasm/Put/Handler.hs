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

import           Helper.Lens

import qualified Model.Germplasm                       as M

import qualified Repository.Germplasm                  as Repository

import           Route.Common.Request
import           Route.Common.Response
import           Route.Germplasm.Put.Presenter.Factory
import qualified Route.Germplasm.Put.RequestBody       as Request

putOneGermplasmR :: M.GermplasmId -> Handler Value
putOneGermplasmR id = do
    jsonBody <- parseJSONBody :: Handler (Either Error Request.PutGermplasmRequestBody)

    germplasm <- join <$> sequence (updateGermplasm id <$> jsonBody)

    let presenter = makePutGermplasmPresenter <$> germplasm

    sendResponse status201 presenter

updateGermplasm :: M.GermplasmId -> Request.PutGermplasmRequestBody -> Handler (Either Error M.Germplasm)
updateGermplasm id body =  do
    let name' = M.GermplasmName $ body^.Request.name
    let attributes' = M.attributesFromMapTextValue $ body^.Request.attributes

    existingGermplasm <- Repository.getOne id

    let updateGermplasmArg = join ((existingGermplasm <&> M.name .~ name') <&> M.attributes .~? attributes')

    _ <- join <$> sequence (Repository.updateOne <$> updateGermplasmArg)

    let updatedGermplasm = Repository.getOne id

    updatedGermplasm

