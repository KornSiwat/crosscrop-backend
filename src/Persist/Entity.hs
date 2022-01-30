{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE UndecidableInstances       #-}

module Persist.Entity where

import           ClassyPrelude.Yesod

import           Persist.Field.JsonB


share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|

  UserEntity sql=user
    ident Text
    password Text Maybe
    UniqueUser ident
    deriving Typeable

  GermplasmEntity sql=germplasm
    name Text
    attributes JsonB
    workflowId WorkflowComponentEntityId
    createdOn UTCTime default=now()
    updatedOn UTCTime Maybe
    deletedOn UTCTime Maybe

  WorkflowComponentEntity sql=workflow_component
    name Text
    seasonId  SeasonEntityId
    createdOn UTCTime default=now()
    updatedOn UTCTime Maybe
    deletedOn UTCTime Maybe

  SeasonEntity sql=season
    seasonNo Int
    year Int
  |]
