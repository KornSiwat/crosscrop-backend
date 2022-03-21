{-# LANGUAGE NoImplicitPrelude #-}

module Persist.Factory.Germplasm where

import           Import

import           Control.Lens

import qualified Model.Germplasm     as M

import           Persist.Entity      (GermplasmEntity (GermplasmEntity))
import           Persist.Field.JsonB

fromGermplasm :: M.Germplasm -> GermplasmEntity
fromGermplasm x = do
    let (M.GermplasmName name) = x^.M.name
    let attributes = JsonB . toJSON $ x^.M.attributes
    let (M.CreatedOn createdOn) = x^.M.createdOn
    let updatedOn = (x^.M.updatedOn) >>= (\(M.UpdatedOn updatedOn') -> Just updatedOn')
    let deletedOn = x^.M.deletedOn >>= (\(M.DeletedOn deletedOn') -> Just deletedOn')

    GermplasmEntity name attributes Nothing createdOn updatedOn deletedOn

