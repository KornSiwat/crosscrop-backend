{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Delete.Handler where

import           Import

import qualified Model.Germplasm       as M

import qualified Repository.Germplasm  as RP

import           Route.Common.Response

deleteOneGermplasmR :: M.GermplasmId -> Handler Value
deleteOneGermplasmR id = do
    deleteResult <- RP.deleteOne id

    let deleteSuccessMessage = tshow id ++ " deleted"

    sendResponse status200 (deleteResult $> deleteSuccessMessage)

