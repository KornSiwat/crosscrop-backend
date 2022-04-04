{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Germplasm.Read where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import           Helper.TypeConverter

import qualified Model.Germplasm      as M

import           Persist.Entity

import           Repository.Common

getAll :: Handler (Either Error [M.Germplasm])
getAll = getManyBy [] []

getById :: M.GermplasmId -> Handler (Either Error M.Germplasm)
getById id = getFirstBy [GermplasmEntityId ==. toKey id] []

getByIds :: [M.GermplasmId] -> Handler (Either Error [M.Germplasm])
getByIds ids = getManyBy [GermplasmEntityId <-. ids'] []
    where ids' = map toKey ids

getManyBy :: [Filter GermplasmEntity]
          -> [SelectOpt GermplasmEntity]
          -> Handler (Either Error [M.Germplasm])
getManyBy filters selectOpts = do
    germplasmEntities <- runDB $ selectList
                                     (baseFilter ++ filters)
                                     selectOpts

    let germplasmModels = mapM M.fromEntity =<< germplasmEntities

    return germplasmModels

getFirstBy :: [Filter GermplasmEntity]
           -> [SelectOpt GermplasmEntity]
           -> Handler (Either Error M.Germplasm)
getFirstBy filters selectOpts = do
    germplasmEntity <- runDB $ selectFirst
                                   (baseFilter ++ filters)
                                   selectOpts

    let germplasmModel = M.fromEntity =<< maybeToEither RecordNotFound =<< germplasmEntity

    return germplasmModel

baseFilter :: [Filter GermplasmEntity]
baseFilter = [GermplasmEntityDeletedOn ==. Nothing]

