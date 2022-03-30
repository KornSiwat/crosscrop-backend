{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Workflow.Delete.Handler where

import           Import

import qualified Model.Workflow        as M

import qualified Repository.Workflow   as RP

import           Route.Common.Response

deleteOneWorkflowR :: M.WorkflowId -> Handler Value
deleteOneWorkflowR id = do
    deleteResult <- RP.deleteOne id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

