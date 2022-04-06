{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Workflow.CRUD.Get.Handler where

import           Import

import           Helper.TypeConverter

import qualified Model.Season                              as M.SS
import qualified Model.Workflow                            as M.WF

import           Route.Common.Response
import           Route.Workflow.CRUD.Get.Presenter.Factory

import qualified Usecase.Workflow                          as UC

getWorkflowR :: Handler Value
getWorkflowR = do
    seasonId <- lookupGetParam "season-id"
    workflowType <- lookupGetParam "type"

    let seasonId' = M.SS.SeasonId <$> (treadMaybe =<< seasonId:: Maybe Int)
    let workflowType' = (treadMaybe =<< workflowType):: Maybe M.WF.WorkflowType

    workflows <- case (seasonId', workflowType') of
                      (Just x, Just y) -> UC.getWorkflowsBySeasonIdAndType x y
                      (Just x, Nothing) -> UC.getWorkflowsBySeasonId x
                      (Nothing, Just y) -> UC.getWorkflowsByType y
                      (Nothing,  Nothing) -> UC.getAllWorkflow

    let presenter = makeGetWorkflowPresenter <$> workflows

    sendResponse status200 presenter

getOneWorkflowR :: M.WF.WorkflowId -> Handler Value
getOneWorkflowR id = do
    workflow <- UC.getWorkflowById id

    let presenter = makeGetOneWorkflowPresenter <$> workflow

    sendResponse status200 presenter

