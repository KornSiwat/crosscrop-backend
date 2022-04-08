module Route.Season.Common.SeasonPresenter.Factory where

import           Control.Lens

import qualified Model.Season                                   as M

import           Route.Season.Common.SeasonPresenter.Definition

fromSeason :: M.Season
           -> SeasonPresenter
fromSeason x
    = SeasonPresenter
        { _id = x^.M.id
        , _year = x^.M.year
        ,_seasonNo = x^.M.seasonNo
        ,_createdOn = x^.M.createdOn
        ,_updatedOn = x^.M.updatedOn
        }
