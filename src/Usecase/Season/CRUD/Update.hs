{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Update where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Season             as M

import qualified Repository.Season        as RP

import qualified Usecase.Season.CRUD.Read as UC

updateSeason :: M.SeasonId
             -> M.Year
             -> M.SeasonNo
             -> Handler (Either Error M.Season)
updateSeason id year seasonNo  =  do
    existingSeason <- UC.getSeasonById id

    let updateSeasonArg = existingSeason
                              <&> M.year .~ year
                              <&> M.seasonNo .~ seasonNo

    updateResult <- join <$> sequence (RP.updateOne <$> updateSeasonArg)

    updatedSeason <- UC.getSeasonById id

    return $ join 
        (updateResult $> updatedSeason)
