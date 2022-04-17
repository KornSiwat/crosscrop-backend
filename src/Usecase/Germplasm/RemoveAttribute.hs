{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.RemoveAttribute where

import           Import

import           Control.Lens

import           Error.Definition

import           Model.Germplasm

import           Usecase.Germplasm.CRUD

removeAttribute :: Germplasm
             -> GermplasmAttributeName
             -> Handler (Either Error Germplasm)
removeAttribute germplasm attributeName = do
    let attributes' = filter
                          (\x ->
                            x^.name /= attributeName)
                          (germplasm^.attributes)

    updateGermplasm
        (germplasm^.id)
        (germplasm^.name)
        attributes'
