{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}

module Repository.Germplasm.Read where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import           Helper.TypeConverter

import qualified Model.Germplasm      as M

import           Persist.Entity

getAll :: Handler (Either Error [M.Germplasm])
getAll = do
    germplasmEntities <- runDB $ selectList [GermplasmEntityDeletedOn ==. Nothing] []

    let germplasmModels = mapM M.fromEntity germplasmEntities

    return germplasmModels

getOne :: M.GermplasmId -> Handler (Either Error M.Germplasm)
getOne id = do
    germplasmEntity <- runDB $ selectFirst [GermplasmEntityId ==. toKey id
                                           ,GermplasmEntityDeletedOn ==. Nothing] 
                                           []

    let germplasmModel = M.fromEntity =<< maybeToEither ToBeDefinedError germplasmEntity

    return germplasmModel

