{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Read where

import           Import

import           Error.Definition

import qualified Model.Season      as M

import qualified Repository.Season as RP

getAllSeason :: Handler (Either Error [M.Season])
getAllSeason = RP.getAll

getSeasonById :: M.SeasonId
                 -> Handler (Either Error M.Season)
getSeasonById = RP.getById

getSeasonByIds :: [M.SeasonId]
               -> Handler (Either Error [M.Season])
getSeasonByIds = RP.getByIds

