{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Season.CRUD.Delete where

import           Import

import           Error.Definition

import qualified Model.Season             as M

import qualified Repository.Season        as RP

import qualified Usecase.Season.CRUD.Read as UC

deleteSeasonById :: M.SeasonId
                 -> Handler (Either Error ())
deleteSeasonById id = do
    existingSeason <- UC.getSeasonById id

    join <$> sequence 
        (existingSeason $> RP.deleteOne id)
