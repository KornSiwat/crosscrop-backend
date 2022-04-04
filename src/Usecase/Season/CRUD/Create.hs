{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Create where

import           Import

import           Error.Definition

import qualified Model.Season      as M

import qualified Repository.Season as RP

createSeason :: M.Year
             -> M.SeasonNo
             -> Handler (Either Error M.Season)
createSeason year seasonNo =  do
    seasonId <- RP.createSeason year seasonNo 

    let season = join <$> sequence (RP.getById <$> seasonId)

    season

