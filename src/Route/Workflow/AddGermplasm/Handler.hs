{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasm.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Workflow                                as M

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.AddGermplasm.Presenter.Factory
import           Route.Workflow.AddGermplasm.RequestBody

import qualified Usecase.Germplasm                             as UC.GP
import qualified Usecase.Workflow                              as UC.WF

postWorkflowAddGermplasmR :: M.WorkflowId 
                          -> Handler Value
postWorkflowAddGermplasmR id = do
    body <- parseJSONBody :: Handler (Either Error WorkflowAddGermplasmRequestBody)

    workflow <- UC.WF.getWorkflowById id
    germplasms <- join <$> sequence (UC.GP.getGermplasmByIds <$> body&^.germplasmIds)
    workflow' <- join <$> sequence
                     (UC.WF.addGermplasms
                         <$> workflow
                         <*> germplasms)

    let presenter = makeWorkflowAddGermplasmPresenter <$> workflow'

    sendResponse status201 presenter
