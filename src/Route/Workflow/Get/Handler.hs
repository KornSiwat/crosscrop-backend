{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Workflow.Get.Handler where

import           Import

import qualified Model.Workflow                       as M

import qualified Repository.Workflow                  as Repository

import           Route.Common.Response
import           Route.Workflow.Get.Presenter.Factory

getOneWorkflowR :: M.WorkflowId -> Handler Value
getOneWorkflowR id = do
    workflow <- Repository.getById id

    let presenter = makeGetOneWorkflowPresenter <$> workflow

    sendResponse status200 presenter

