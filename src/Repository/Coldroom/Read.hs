{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Coldroom.Read where

import           Import

import           Error.Definition

import qualified Model.Coldroom            as M

import qualified Repository.Germplasm.Read as RP.GP

import           Persist.Entity

getColdroom :: Handler (Either Error M.Coldroom)
getColdroom = do
    germplasms <- RP.GP.getManyBy
                      [GermplasmEntityWorkflowId ==. Nothing]
                      []

    let coldroom = M.makeColdroom =<< germplasms

    return coldroom

