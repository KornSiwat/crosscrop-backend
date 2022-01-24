{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.Home where

import           Import

getHomeR :: Handler Value
getHomeR = do
    sendResponseStatus status200 ("CrossCrop Backend Service"::Text)
