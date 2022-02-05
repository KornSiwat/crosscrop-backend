{-# LANGUAGE AllowAmbiguousTypes   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.Germplasm where

import           Import                                     hiding (id)

import           Control.Lens
import           Data.Aeson

import           Model.Germplasm.Common.Attribute           (GermplasmName (..))
import           Model.Germplasm.Common.Factory             (attributesFromMapTextValue)
import           Model.Workflow.Common.Attribute            (WorkflowId (..))
import           Repository.Germplasm                       as RP
import           Request.Germplasm.PostGermplasmRequestBody as RQ

getGermplasmR :: Handler Value
getGermplasmR = do
    getParameters <- reqGetParams <$> getRequest

    germplasms <- getGermplasms

    sendResponseStatus status200 (pack . show $ germplasms::Text)

postGermplasmR :: Handler Value
postGermplasmR = do
    parseRequestBodyResult <- parseCheckJsonBody :: Handler (Result PostGermplasmRequestBody)

    case parseRequestBodyResult of
        Success body -> do
            case attributesFromMapTextValue (body^.RQ.attributes) of
                Just attributes' -> do
                    let args = createGermplasmArgs
                            & RP.name .~ GermplasmName (body^.RQ.name)
                            & RP.workflowId .~ (WorkflowId <$> (body^.RQ.workflowId))
                            & RP.attributes .~ attributes'

                    RP.createGermplasm args

                    sendResponseStatus status200 (pack . show $ body::Text)
                Nothing -> sendResponseStatus status200 ("error"::Text)
        Error errorMessage -> sendResponseStatus status200 (pack errorMessage::Text)


putGermplasmR :: Handler Value
putGermplasmR = do
    sendResponseStatus status200 ("put"::Text)

deleteGermplasmR :: Handler Value
deleteGermplasmR = do
    sendResponseStatus status200 ("delete"::Text)
