module Route.Germplasm.Common.GermplasmPresenter.Factory where

import           Control.Lens

import qualified Model.Germplasm                                      as M

import           Route.Germplasm.Common.GermplasmPresenter.Definition

fromGermplasm :: M.Germplasm
              -> GermplasmPresenter
fromGermplasm x
    = GermplasmPresenter
        { _id = x^.M.id
        , _name = x^.M.name
        ,_attributes = x^.M.attributes
        ,_createdOn = x^.M.createdOn
        ,_updatedOn = x^.M.updatedOn
        }
