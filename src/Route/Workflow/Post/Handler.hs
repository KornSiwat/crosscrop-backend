{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Workflow.Post.Handler where

import           Control.Lens
import           Data.Aeson                            as A
import           Import

import           Error.Definition

import qualified Model.Workflow                        as M

import qualified Repository.Workflow                   as RP

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.Post.Presenter.Factory
import qualified Route.Workflow.Post.RequestBody       as RQ

postWorkflowR :: Handler Value
postWorkflowR = do
    jsonBody <- parseJSONBody :: Handler (Either Error RQ.PostWorkflowRequestBody)

    workflowId <- join <$> sequence (createWorkflow <$> jsonBody)

    let presenter = makePostWorkflowPresenter <$> workflowId

    sendResponse status201 presenter

createWorkflow :: RQ.PostWorkflowRequestBody -> Handler (Either Error M.WorkflowId)
createWorkflow body =  do
    let name = body^.RQ.name
    let seasonId = body^.RQ.seasonId

    let workflowId = RP.createWorkflow name seasonId

    workflowId

