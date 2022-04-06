{-# LANGUAGE NoImplicitPrelude #-}

module Repository.Season.Delete where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Season       as M

import           Persist.Entity

import           Repository.Common

deleteOne :: M.SeasonId
          -> Handler (Either Error ())
deleteOne id = do
    currentTime <- liftIO getCurrentTime

    let id' = toKey id
    let deletedOn = Just currentTime

    runDB $ update
               id'
               [SeasonEntityDeletedOn =. deletedOn]

