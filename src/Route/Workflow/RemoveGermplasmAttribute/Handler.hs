{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.RemoveGermplasmAttribute.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Germplasm                                           as M.GP
import qualified Model.Workflow                                            as M.WF

import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.RemoveGermplasmAttribute.Presenter.Factory

import qualified Usecase.Workflow                                          as UC.WF

deleteOneWorkflowGermplasmAttributeR :: M.WF.WorkflowId
                                     -> M.GP.GermplasmAttributeName
                                     -> Handler Value
deleteOneWorkflowGermplasmAttributeR id germplasmAttributeName = do
    workflow <- UC.WF.getWorkflowById id

    workflow' <- join <$> sequence
                     (UC.WF.removeGermplasmAttribute
                         <$> workflow
                         <*> pure germplasmAttributeName)

    let presenter = makeWorkflowRemoveGermplasmAttributePresenter <$> workflow'

    sendResponse status201 presenter
