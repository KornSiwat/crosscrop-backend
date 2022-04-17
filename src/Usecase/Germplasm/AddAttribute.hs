{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.AddAttribute where

import           Import

import           Control.Lens

import           Error.Definition

import           Model.Germplasm

import           Usecase.Germplasm.CRUD

addAttribute :: Germplasm
             -> GermplasmAttribute
             -> Handler (Either Error Germplasm)
addAttribute germplasm attribute =
    updateGermplasm
        (germplasm^.id)
        (germplasm^.name)
        (germplasm^.attributes ++ [attribute])
