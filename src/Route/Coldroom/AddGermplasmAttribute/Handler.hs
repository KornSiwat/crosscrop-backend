{-# LANGUAGE NoImplicitPrelude #-}

module Route.Coldroom.AddGermplasmAttribute.Handler where

import           Import

import           Error.Definition

import           Helper.Lens

import qualified Model.Germplasm                                        as M.GP

import           Route.Coldroom.AddGermplasmAttribute.Presenter.Factory
import           Route.Coldroom.AddGermplasmAttribute.RequestBody
import           Route.Common.Request
import           Route.Common.Response

import qualified Usecase.Coldroom                                       as UC.CR

postColdroomGermplasmAttributeR :: Handler Value
postColdroomGermplasmAttributeR = do
    body <- parseJSONBody :: Handler (Either Error ColdroomAddGermplasmAttributeRequestBody)

    let attribute = M.GP.GermplasmAttribute
                        <$> (body&^.name)
                        <*> (body&^.germplasmAttributeType)
                        <*> pure M.GP.GermplasmAttributeNull

    coldroom' <- join <$> sequence
                     (UC.CR.addGermplasmAttribute
                         <$> attribute)

    let presenter = makeColdroomAddGermplasmAttributePresenter <$> coldroom'

    sendResponse status201 presenter
