{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Update where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Season      as M

import qualified Repository.Season as RP

updateSeason :: M.SeasonId
             -> M.Year
             -> M.SeasonNo
             -> Handler (Either Error M.Season)
updateSeason id year seasonNo  =  do
    existingSeason <- RP.getById id

    let updateSeasonArg = existingSeason
                                 <&> M.year .~ year
                                 <&> M.seasonNo .~ seasonNo

    updateResult <- join <$> sequence (RP.updateOne <$> updateSeasonArg)

    updatedSeason <- RP.getById id

    return $ join (updateResult $> updatedSeason)

