{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Coldroom.Definition where

import           Import

import           Control.Lens    (makeFieldsNoPrefix)

import qualified Model.Germplasm as GP

-- Coldroom
newtype Coldroom
    = Coldroom
        { _germplasms :: [GP.Germplasm]
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''Coldroom
