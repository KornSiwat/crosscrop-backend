{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.RemoveGermplasmAttribute where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm       as M.GP
import qualified Model.Workflow        as M.WF

import qualified Usecase.Germplasm     as UC.GP
import qualified Usecase.Workflow.CRUD as UC.WF.CRUD

removeGermplasmAttribute :: M.WF.Workflow
                         -> M.GP.GermplasmAttributeName
                         -> Handler (Either Error M.WF.Workflow)
removeGermplasmAttribute workflow attributeName = do
    let workflowId = workflow^.M.WF.id

    let germplasms = workflow^.M.WF.germplasms

    germplasms' <- sequence <$> mapM
                                 (`UC.GP.removeAttribute` attributeName)
                                 germplasms

    workflow' <- UC.WF.CRUD.getWorkflowById workflowId

    return $ join (germplasms' $> workflow')
