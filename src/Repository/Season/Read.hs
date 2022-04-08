{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Season.Read where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import           Helper.TypeConverter

import qualified Model.Season         as M

import           Persist.Entity

import           Repository.Common

getAll :: Handler (Either Error [M.Season])
getAll = getManyBy
             []
             []

getByYear :: M.Year
          -> Handler (Either Error [M.Season])
getByYear (M.Year year) = do
    let seasons = getManyBy
                   [SeasonEntityYear ==. year]
                   []

    seasons

getBySeasonNo :: M.SeasonNo
              -> Handler (Either Error [M.Season])
getBySeasonNo (M.SeasonNo seasonNo) = do
    let seasons = getManyBy
                   [SeasonEntitySeasonNo ==. seasonNo]
                   []

    seasons

getByYearAndSeasonNo :: M.Year
                     -> M.SeasonNo
                     -> Handler (Either Error [M.Season])
getByYearAndSeasonNo (M.Year year) (M.SeasonNo seasonNo) = do
    let seasons = getManyBy
                   [SeasonEntityYear ==. year
                   ,SeasonEntitySeasonNo ==. seasonNo]
                   []

    seasons

getById :: M.SeasonId
        -> Handler (Either Error M.Season)
getById id = getFirstBy
                 [SeasonEntityId ==. toKey id]
                 []

getByIds :: [M.SeasonId]
         -> Handler (Either Error [M.Season])
getByIds ids = do
    let ids' = map toKey ids

    seasons <- getManyBy
                   [SeasonEntityId <-. ids']
                   []

    return $ case seasons of
        Right xs -> if length xs == length ids
                    then Right xs
                    else Left RecordNotFound
        Left e   -> Left e

getManyBy :: [Filter SeasonEntity]
          -> [SelectOpt SeasonEntity]
          -> Handler (Either Error [M.Season])
getManyBy filters selectOpts = do
    seasonEntities <- runDB $ selectList
                                  (baseFilter ++ filters)
                                  selectOpts

    let seasonModels = mapM M.fromEntity =<< seasonEntities

    return seasonModels

getFirstBy :: [Filter SeasonEntity]
           -> [SelectOpt SeasonEntity]
           -> Handler (Either Error M.Season)
getFirstBy filters selectOpts = do
    seasonEntity <- runDB $ selectFirst
                                (baseFilter ++ filters)
                                selectOpts

    let seasonModel = M.fromEntity
                          =<< maybeToEither RecordNotFound
                          =<< seasonEntity

    return seasonModel

baseFilter :: [Filter SeasonEntity]
baseFilter = [SeasonEntityDeletedOn ==. Nothing]
