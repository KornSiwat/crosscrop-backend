{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Germplasm.Delete where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Germplasm    as M

import           Persist.Entity

import           Repository.Common

deleteOne :: M.GermplasmId
          -> Handler (Either Error ())
deleteOne id = do
    currentTime <- liftIO getCurrentTime

    let id' = toKey id
    let deletedOn = Just currentTime

    runDB $ update
                id'
                [GermplasmEntityDeletedOn =. deletedOn]
