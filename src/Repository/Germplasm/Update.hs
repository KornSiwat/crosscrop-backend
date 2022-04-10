{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Germplasm.Update where

import           Import

import           Class.ToPersistKey

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm    as M

import           Persist.Entity

import           Repository.Common

updateOne :: M.Germplasm
          -> Handler (Either Error ())
updateOne germplasm = do
    currentTime <- liftIO getCurrentTime

    let id = toKey $ germplasm^.M.id
    let (M.GermplasmName name) = germplasm^.M.name
    let attributes = map tshow (germplasm^.M.attributes)
    let updatedOn = Just currentTime

    runDB $ update
                id
                [GermplasmEntityName =. name
                ,GermplasmEntityAttributes =. attributes
                ,GermplasmEntityUpdatedOn =. updatedOn]
