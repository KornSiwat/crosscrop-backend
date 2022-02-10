{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NamedFieldPuns         #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Repository.Germplasm.Read where

import           Import

import           Error.Definition
import           Model.Germplasm.Common.Definition (Germplasm)
import           Model.Germplasm.Common.Factory    (fromEntity)
import           Persist.Entity

getGermplasms :: Handler (Either Error [Germplasm])
getGermplasms = do
    germplasmEntities <- runDB $ selectList ([]:: [Filter GermplasmEntity]) []

    let germplasmModels = sequence $ map fromEntity germplasmEntities

    return germplasmModels
