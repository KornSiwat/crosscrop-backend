{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}

module Repository.Germplasm.Delete where

import           Import

import           Class.ToPersistKey

import           Error.Definition

import qualified Model.Germplasm     as M

import           Persist.Entity

import           UnliftIO.Exception  (catch)

deleteOne :: M.GermplasmId -> Handler (Either Error ())
deleteOne id = do
    currentTime <- liftIO getCurrentTime

    let id' = toKey id
    let deletedOn = Just currentTime

    Right <$>
        runDB
            (update
             id'
             [GermplasmEntityDeletedOn =. deletedOn])
    `catch` (\(SomeException _) -> return $ Left ToBeDefinedError)

