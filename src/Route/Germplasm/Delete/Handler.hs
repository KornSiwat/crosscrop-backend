{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Delete.Handler where

import           Import

import qualified Model.Germplasm                       as M

import qualified Repository.Germplasm                  as Repository

import           Route.Common.Response

deleteOneGermplasmR :: M.GermplasmId -> Handler Value
deleteOneGermplasmR id = do
    deleteResult <- Repository.deleteOne id

    let deleteSuccessMessage = "Germplasm Id:" ++ tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

