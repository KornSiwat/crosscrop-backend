{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Helper.Response where

import           Import           hiding (error)

import           Error.Definition

sendResponse :: ToJSON a => Status -> Either Error a -> Handler Value
sendResponse status eitherPresenter = case eitherPresenter of
    Right presenter -> sendSuccessResponse status presenter
    Left error      -> sendErrorResponse error

sendSuccessResponse :: ToJSON a => Status -> a -> Handler Value
sendSuccessResponse status presenter = sendResponseStatus status (toJSON presenter)

sendErrorResponse :: Error -> Handler Value
sendErrorResponse error = case  error of
    _ -> sendResponseStatus status500 errorText
    where
        errorText = (tshow $ error::Text)
