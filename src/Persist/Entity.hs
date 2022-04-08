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
        deriving Typeable Show

    GermplasmEntity sql=germplasm
        name Text
        attributes JsonB
        workflowId WorkflowEntityId Maybe
        createdOn UTCTime default=now()
        updatedOn UTCTime Maybe
        deletedOn UTCTime Maybe
        deriving Show

    WorkflowEntity sql=workflow
        workflowType Text
        name Text
        seasonId  SeasonEntityId
        createdOn UTCTime default=now()
        updatedOn UTCTime Maybe
        deletedOn UTCTime Maybe
        deriving Show

    SeasonEntity sql=season
        year Int
        seasonNo Int
        createdOn UTCTime default=now()
        updatedOn UTCTime Maybe
        deletedOn UTCTime Maybe
        deriving Show
  |]
