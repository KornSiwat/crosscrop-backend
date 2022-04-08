{-# LANGUAGE NoImplicitPrelude #-}

module Model.Coldroom.Factory where

import           Import

import           Error.Definition

import           Model.Coldroom.Definition
import qualified Model.Germplasm           as GP

-- Coldroom
makeColdroom :: [GP.Germplasm]
             -> Either Error Coldroom
makeColdroom = Right . Coldroom
