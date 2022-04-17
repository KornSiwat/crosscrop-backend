{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Coldroom.RemoveGermplasmAttribute where

import           Import

import           Error.Definition

import qualified Model.Coldroom        as M.CR
import qualified Model.Germplasm       as M.GP

import           Helper.Lens

import qualified Usecase.Coldroom.Read as UC.CR.Read
import qualified Usecase.Germplasm     as UC.GP

removeGermplasmAttribute :: M.GP.GermplasmAttributeName
                         -> Handler (Either Error M.CR.Coldroom)
removeGermplasmAttribute attributeName = do
    coldroom <- UC.CR.Read.getColdroom
    let germplasms = coldroom&^.M.CR.germplasms

    germplasms' <-  join <$> sequence (
                        fmap sequence <$>
                            (mapM
                                (`UC.GP.removeAttribute` attributeName)
                                <$> germplasms))

    coldroom' <- UC.CR.Read.getColdroom

    return $ join (germplasms' $> coldroom')
