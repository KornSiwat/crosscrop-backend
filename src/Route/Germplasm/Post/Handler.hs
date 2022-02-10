{-# LANGUAGE AllowAmbiguousTypes    #-}
{-# LANGUAGE DuplicateRecordFields  #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}
{-# LANGUAGE TypeFamilies           #-}

module Route.Germplasm.Post.Handler where

import           Import                           hiding (id)

import           Control.Lens
import           Data.Aeson

import           Error.Definition

import           Route.Germplasm.Post.RequestBody as RQ

import           Model.Germplasm.Common.Attribute (GermplasmName (..))
import           Model.Germplasm.Common.Factory   (attributesFromMapTextValue)
import           Model.Workflow.Common.Attribute  (WorkflowId (..))

import           Repository.Germplasm.Create      as RP


postGermplasmR :: Handler Value
postGermplasmR = do
    parseRequestBodyResult <- parseCheckJsonBody :: Handler (Result PostGermplasmRequestBody)

    case parseRequestBodyResult of
        Success body -> do
            case attributesFromMapTextValue (body^.RQ.attributes) of
                Right attributes' -> do
                    let args = createGermplasmArgs
                            & RP.name .~ GermplasmName (body^.RQ.name)
                            & RP.workflowId .~ (WorkflowId <$> (body^.RQ.workflowId))
                            & RP.attributes .~ attributes'

                    _ <- createGermplasm args

                    sendResponseStatus status200 (pack . show $ body::Text)
                Left ToBeDefinedError -> sendResponseStatus status200 ("error"::Text)
        Error errorMessage -> sendResponseStatus status200 (pack errorMessage::Text)
