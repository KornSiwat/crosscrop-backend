{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Read where

import           Import

import           Error.Definition

import qualified Model.Season      as M

import qualified Repository.Season as RP

getAllSeason :: Handler (Either Error [M.Season])
getAllSeason = RP.getAll

getSeasonsByYear :: M.Year
                 -> Handler (Either Error [M.Season])
getSeasonsByYear = RP.getByYear

getSeasonsBySeasonNo :: M.SeasonNo
                     -> Handler (Either Error [M.Season])
getSeasonsBySeasonNo = RP.getBySeasonNo

getSeasonsByYearAndSeasonNo :: M.Year
                            -> M.SeasonNo
                            -> Handler (Either Error [M.Season])
getSeasonsByYearAndSeasonNo = RP.getByYearAndSeasonNo

getSeasonById :: M.SeasonId
              -> Handler (Either Error M.Season)
getSeasonById = RP.getById

getSeasonByIds :: [M.SeasonId]
               -> Handler (Either Error [M.Season])
getSeasonByIds = RP.getByIds

