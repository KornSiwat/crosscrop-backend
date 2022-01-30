{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.Germplasm where

import           Import               hiding (id)

import           Control.Lens
import           Data.Aeson
import           Repository.Germplasm as GermplasmRepository

getGermplasmR :: Handler Value
getGermplasmR = do
    getParameters <- reqGetParams <$> getRequest

    germplasms <- GermplasmRepository.getGermplasms

    sendResponseStatus status200 (pack . show $ germplasms::Text)

postGermplasmR :: Handler Value
postGermplasmR = do
    
    sendResponseStatus status200 ("post"::Text)

putGermplasmR :: Handler Value
putGermplasmR = do
    sendResponseStatus status200 ("put"::Text)

deleteGermplasmR :: Handler Value
deleteGermplasmR = do
    sendResponseStatus status200 ("delete"::Text)
