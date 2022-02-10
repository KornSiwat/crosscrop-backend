{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Route.Germplasm.Get.Handler where

import           Import                    hiding (id)

import           Repository.Germplasm.Read

getGermplasmR :: Handler Value
getGermplasmR = do
    getParameters <- reqGetParams <$> getRequest

    germplasms <- getGermplasms

    sendResponseStatus status200 (pack . show $ germplasms::Text)
