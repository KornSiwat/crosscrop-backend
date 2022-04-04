{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Season      as M

import qualified Repository.Season as RP

deleteSeasonById :: M.SeasonId
                 -> Handler (Either Error ())
deleteSeasonById = RP.deleteOne

