{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Create where

import           Import

import           Error.Definition

import qualified Model.Germplasm      as M.GP
import qualified Model.Workflow       as M.WF

import qualified Repository.Germplasm as RP

createGermplasm :: M.GP.GermplasmName
                -> Maybe M.WF.WorkflowId
                -> [M.GP.GermplasmAttribute]
                -> Handler (Either Error M.GP.Germplasm)
createGermplasm name workflowId attributes =  do
    germplasmId <- RP.createGermplasm
                       name
                       workflowId
                       attributes

    let germplasm = join <$> sequence (RP.getById <$> germplasmId)

    germplasm
