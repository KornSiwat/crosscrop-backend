{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Germplasm.CRUD.Update where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Germplasm             as M

import qualified Repository.Germplasm        as RP

import qualified Usecase.Germplasm.CRUD.Read as UC

updateGermplasm :: M.GermplasmId
                -> M.GermplasmName
                -> [M.GermplasmAttribute]
                -> Handler (Either Error M.Germplasm)
updateGermplasm id name attributes  =  do
    existingGermplasm <- UC.getGermplasmById id

    let updateGermplasmArg = existingGermplasm
                                 <&> M.name .~ name
                                 <&> M.attributes .~ attributes

    updateResult <- join <$> sequence (RP.updateOne <$> updateGermplasmArg)

    updatedGermplasm <- UC.getGermplasmById id

    return $ join
        (updateResult $> updatedGermplasm)
