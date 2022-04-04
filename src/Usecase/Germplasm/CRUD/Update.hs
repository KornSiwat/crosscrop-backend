{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Update where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm      as M

import qualified Repository.Germplasm as RP

updateGermplasm :: M.GermplasmId
                -> M.GermplasmName
                -> M.Attributes
                -> Handler (Either Error M.Germplasm)
updateGermplasm id name attributes  =  do
    existingGermplasm <- RP.getById id

    let updateGermplasmArg = existingGermplasm
                                 <&> M.name .~ name
                                 <&> M.attributes .~ attributes

    updateResult <- join <$> sequence (RP.updateOne <$> updateGermplasmArg)

    updatedGermplasm <- RP.getById id

    return $ join (updateResult $> updatedGermplasm)

