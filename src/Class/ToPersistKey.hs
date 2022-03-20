{-# LANGUAGE FlexibleContexts #-}

module Class.ToPersistKey where

import           Database.Persist.Sql

class ToPersistKey a where
    toKey :: ToBackendKey SqlBackend record => a -> Key record

