{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.RemoveGermplasmAttribute.Handler where

import           Import

import qualified Model.Germplasm                                           as M.GP

import           Route.Coldroom.RemoveGermplasmAttribute.Presenter.Factory
import           Route.Common.Response

import qualified Usecase.Coldroom                                          as UC.CR

deleteOneColdroomGermplasmAttributeR :: M.GP.GermplasmAttributeName
                                     -> Handler Value
deleteOneColdroomGermplasmAttributeR name = do
    coldroom' <- UC.CR.removeGermplasmAttribute name

    let presenter = makeColdroomRemoveGermplasmAttributePresenter <$> coldroom'

    sendResponse status201 presenter
