{-# LANGUAGE FlexibleContexts #-}

module Class.ToKey where

import           Database.Persist.Sql

class ToKey a where
    toKey :: ToBackendKey SqlBackend record => a -> Key record
