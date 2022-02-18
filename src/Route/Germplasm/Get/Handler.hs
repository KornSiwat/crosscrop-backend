{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Get.Handler where

import           Control.Monad
import           Import                                hiding (id)

import           Repository.Germplasm.Read
import           Route.Germplasm.Get.Presenter.Factory

getGermplasmR :: Handler Value
getGermplasmR = do
    germplasms <- getGermplasms

    case makeGetGermplasmPresenter <$!> germplasms of
        Right presenter -> sendResponseStatus status200 (toJSON presenter)
        Left error'     -> sendResponseStatus status500 (tshow $ error'::Text)
