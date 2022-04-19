{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Coldroom.AddGermplasmAttribute where

import           Import

import           Error.Definition

import qualified Model.Coldroom        as M.CR
import qualified Model.Germplasm       as M.GP

import           Helper.Lens

import qualified Usecase.Coldroom.Read as UC.CR.Read
import qualified Usecase.Germplasm     as UC.GP

addGermplasmAttribute :: M.GP.GermplasmAttribute
                      -> Handler (Either Error M.CR.Coldroom)
addGermplasmAttribute attribute = do
    coldroom <- UC.CR.Read.getColdroom
    let germplasms = coldroom&^.M.CR.germplasms

    germplasms' <-  join <$> sequence (
                        fmap sequence <$>
                            (mapM
                                (`UC.GP.addAttribute` attribute)
                                <$> germplasms))

    coldroom' <- UC.CR.Read.getColdroom

    return $ join (germplasms' $> coldroom')