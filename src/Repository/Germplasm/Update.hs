{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}

module Repository.Germplasm.Update where

import           Import

import           Class.ToPersistKey

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm     as M

import           Persist.Entity
import           Persist.Field.JsonB

import           UnliftIO.Exception  (catch)

updateOne :: M.Germplasm -> Handler (Either Error ())
updateOne germplasm = do
    currentTime <- liftIO getCurrentTime

    let id = toKey $ germplasm^.M.id
    let (M.GermplasmName name) = germplasm^.M.name
    let attributes = JsonB . toJSON $ germplasm^.M.attributes
    let updatedOn = Just currentTime

    Right <$>
        runDB
            (update
             id
             [GermplasmEntityName =. name,
              GermplasmEntityAttributes =. attributes,
              GermplasmEntityUpdatedOn =. updatedOn
             ])
    `catch` (\(SomeException _) -> return $ Left ToBeDefinedError)

