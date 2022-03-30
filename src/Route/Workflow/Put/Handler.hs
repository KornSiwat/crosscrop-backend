{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Workflow.Put.Handler where

import           Import

import           Control.Lens

import           Error.Definition

import           Helper.Lens

import qualified Model.Workflow                       as M

import qualified Repository.Season                    as RP.Season
import qualified Repository.Workflow                  as RP.Workflow

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.Put.Presenter.Factory
import qualified Route.Workflow.Put.RequestBody       as RQ

putOneWorkflowR :: M.WorkflowId -> Handler Value
putOneWorkflowR id = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PutWorkflowRequestBody)

    germplasm <- join <$> sequence (updateWorkflow id <$> jsonBody)

    let presenter = makePutWorkflowPresenter <$> germplasm

    sendResponse status200 presenter

updateWorkflow :: M.WorkflowId -> RQ.PutWorkflowRequestBody -> Handler (Either Error M.Workflow)
updateWorkflow id body =  do
    let name = body^.RQ.name
    season <- sequence <$> sequence (RP.Season.getById <$> (body^.RQ.seasonId))

    existingWorkflow <- RP.Workflow.getById id

    let updateWorkflowArg = join $ existingWorkflow
                                       <&> M.name .~ name
                                       <&> M.season .~? season

    updateResult <- sequence (RP.Workflow.updateOne <$> updateWorkflowArg)

    updatedWorkflow <- RP.Workflow.getById id

    return $ join (updateResult $> updatedWorkflow)

