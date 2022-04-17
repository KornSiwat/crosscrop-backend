{-# LANGUAGE NoImplicitPrelude #-}

module Route.Workflow.AddGermplasmAttribute.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Germplasm                                        as M.GP
import qualified Model.Workflow                                         as M.WF
import           Route.Common.Request
import           Route.Common.Response
import           Route.Workflow.AddGermplasmAttribute.Presenter.Factory
import           Route.Workflow.AddGermplasmAttribute.RequestBody

import qualified Usecase.Workflow                                       as UC.WF

postWorkflowGermplasmAttributeR :: M.WF.WorkflowId
                                   -> Handler Value
postWorkflowGermplasmAttributeR id = do
    body <- parseJSONBody :: Handler (Either Error WorkflowAddGermplasmAttributeRequestBody)

    workflow <- UC.WF.getWorkflowById id
    let attribute = M.GP.GermplasmAttribute
                        <$> (body&^.name)
                        <*> (body&^.germplasmAttributeType)
                        <*> pure M.GP.GermplasmAttributeNull

    workflow' <- join <$> sequence
                     (UC.WF.addGermplasmAttribute
                         <$> workflow
                         <*> attribute)

    let presenter = makeWorkflowAddGermplasmAttributePresenter <$> workflow'

    sendResponse status201 presenter
