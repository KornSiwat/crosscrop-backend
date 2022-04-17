{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.RemoveGermplasmAttribute.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Workflow                                            as M.WF
import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.RemoveGermplasmAttribute.Presenter.Factory
import           Route.Workflow.RemoveGermplasmAttribute.RequestBody

import qualified Usecase.Workflow                                          as UC.WF

deleteWorkflowGermplasmAttributeR :: M.WF.WorkflowId
                                  -> Handler Value
deleteWorkflowGermplasmAttributeR id = do
    body <- parseJSONBody :: Handler (Either Error WorkflowRemoveGermplasmAttributeRequestBody)

    workflow <- UC.WF.getWorkflowById id

    workflow' <- join <$> sequence
                     (UC.WF.removeGermplasmAttribute
                         <$> workflow
                         <*> body&^.name)

    let presenter = makeWorkflowRemoveGermplasmAttributePresenter <$> workflow'

    sendResponse status201 presenter
