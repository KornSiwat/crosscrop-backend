module Route.Coldroom.Common.ColdroomPresenter.Factory where

import           Control.Lens

import qualified Model.Coldroom                                     as M

import           Route.Coldroom.Common.ColdroomPresenter.Definition
import qualified Route.Germplasm.Common.Presenter                   as P.GP

fromColdroom :: M.Coldroom
             -> ColdroomPresenter
fromColdroom x = ColdroomPresenter
                    { _germplasms = map P.GP.fromGermplasm (x^.M.germplasms)
                    }
