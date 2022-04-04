{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Germplasm      as M

import qualified Repository.Germplasm as RP

deleteGermplasmById :: M.GermplasmId
                 -> Handler (Either Error ())
deleteGermplasmById = RP.deleteOne

