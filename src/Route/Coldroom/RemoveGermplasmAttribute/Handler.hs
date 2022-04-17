{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.RemoveGermplasmAttribute.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import           Route.Coldroom.RemoveGermplasmAttribute.Presenter.Factory
import           Route.Coldroom.RemoveGermplasmAttribute.RequestBody
import           Route.Common.Request
import           Route.Common.Response

import qualified Usecase.Coldroom                                          as UC.CR

deleteColdroomGermplasmAttributeR :: Handler Value
deleteColdroomGermplasmAttributeR = do
    body <- parseJSONBody :: Handler (Either Error ColdroomRemoveGermplasmAttributeRequestBody)

    coldroom' <- join <$> sequence
                     (UC.CR.removeGermplasmAttribute
                         <$> body&^.name)

    let presenter = makeColdroomRemoveGermplasmAttributePresenter <$> coldroom'

    sendResponse status201 presenter
