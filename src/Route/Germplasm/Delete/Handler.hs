{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}

module Route.Germplasm.Delete.Handler where

import           Import

import qualified Model.Germplasm               as M

import           Route.Common.Response

import qualified Usecase.Germplasm.CRUD.Delete as UC

deleteOneGermplasmR :: M.GermplasmId -> Handler Value
deleteOneGermplasmR id = do
    deleteResult <- UC.deleteGermplasmById id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

