{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}

module Repository.Germplasm.Read where

import           Import

import           Error.Definition

import           Helper.TypeConverter

import           Model.Germplasm.Common.Definition (Germplasm)
import           Model.Germplasm.Common.Factory    (fromEntity)

import           Persist.Entity

getAll :: Handler (Either Error [Germplasm])
getAll = do
    germplasmEntities <- runDB $ selectList ([]:: [Filter GermplasmEntity]) []

    let germplasmModels = mapM fromEntity germplasmEntities

    return germplasmModels

getOne :: GermplasmEntityId -> Handler (Either Error Germplasm)
getOne id = do
    germplasmEntity <- runDB $ selectFirst [GermplasmEntityId ==. id] []

    let germplasmModel = fromEntity =<< maybeToEither ToBeDefinedError germplasmEntity

    return germplasmModel
