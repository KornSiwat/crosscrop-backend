{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Read where

import           Import

import           Error.Definition

import qualified Model.Germplasm      as M

import qualified Repository.Germplasm as RP

getAllGermplasm :: Handler (Either Error [M.Germplasm])
getAllGermplasm = RP.getAll

getGermplasmById :: M.GermplasmId
                 -> Handler (Either Error M.Germplasm)
getGermplasmById = RP.getById

getGermplasmByIds :: [M.GermplasmId]
                  -> Handler (Either Error [M.Germplasm])
getGermplasmByIds = RP.getByIds
