{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Coldroom.AddGermplasm where

import           Import

import           Control.Lens

import           Error.Definition

import qualified Model.Coldroom        as M.CR
import qualified Model.Germplasm       as M.GP

import qualified Usecase.Coldroom.Read as UC.CR
import qualified Usecase.Germplasm     as UC.GP

addGermplasms :: [M.GP.Germplasm]
              -> Handler (Either Error M.CR.Coldroom)
addGermplasms germplasms = do
    germplasms' <- sequence <$>
                       mapM
                          (\germplasm ->
                              UC.GP.createGermplasm
                                  (germplasm^.M.GP.name)
                                  Nothing
                                  (germplasm^.M.GP.attributes))
                           germplasms

    join <$> sequence
        (germplasms' $> UC.CR.getColdroom)

