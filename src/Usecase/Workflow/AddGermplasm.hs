{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Workflow.AddGermplasm where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm       as M.GP
import qualified Model.Workflow        as M.WF

import qualified Usecase.Germplasm     as UC.GP
import qualified Usecase.Workflow.CRUD as UC.WF.CRUD

addGermplasms :: M.WF.Workflow
              -> [M.GP.Germplasm]
              -> Handler (Either Error M.WF.Workflow)
addGermplasms workflow germplasms = do
    let workflowId = workflow^.M.WF.id

    germplasms' <- sequence
                       <$> mapM
                               (\germplasm
                                   -> UC.GP.createGermplasm
                                          (germplasm^.M.GP.name)
                                          (Just workflowId)
                                          (germplasm^.M.GP.attributes))
                               germplasms

    workflow' <- UC.WF.CRUD.getWorkflowById workflowId

    return $ join (germplasms' $> workflow')
