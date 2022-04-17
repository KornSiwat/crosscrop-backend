{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.AddGermplasmAttribute where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm       as M.GP
import qualified Model.Workflow        as M.WF

import qualified Usecase.Germplasm     as UC.GP
import qualified Usecase.Workflow.CRUD as UC.WF.CRUD

addGermplasmAttribute :: M.WF.Workflow
                      -> M.GP.GermplasmAttribute
                      -> Handler (Either Error M.WF.Workflow)
addGermplasmAttribute workflow attribute = do
    let workflowId = workflow^.M.WF.id

    let germplasms = workflow^.M.WF.germplasms

    germplasms' <- sequence <$> mapM
                                 (`UC.GP.addAttribute` attribute)
                                 germplasms

    workflow' <- UC.WF.CRUD.getWorkflowById workflowId

    return $ join (germplasms' $> workflow')
