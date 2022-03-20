{-# LANGUAGE NoImplicitPrelude #-}

module Route.Common.Response where

import           Import                 hiding (error)

import           Error.Definition

import           Route.Common.Presenter

sendResponse :: ToJSON a => Status -> Either Error a -> Handler Value
sendResponse status eitherPresenter = case eitherPresenter of
    Right presenter -> sendSuccessResponse status presenter
    Left error      -> sendErrorResponse error

sendSuccessResponse :: ToJSON a => Status -> a -> Handler Value
sendSuccessResponse status presenter = sendResponseStatus status (toJSON presenter)

sendErrorResponse :: Error -> Handler Value
sendErrorResponse error = case error of
    _ -> sendResponseStatus status500 response
    where
        response = toJSON presenter
        presenter = makeErrorPresenter error
