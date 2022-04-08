{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Germplasm             as M

import qualified Repository.Germplasm        as RP

import qualified Usecase.Germplasm.CRUD.Read as UC

deleteGermplasmById :: M.GermplasmId
                    -> Handler (Either Error ())
deleteGermplasmById id = do
    existingGermplasm <- UC.getGermplasmById id

    join <$> sequence (existingGermplasm $> RP.deleteOne id)
