{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Common.Presenter where

import           Import                     hiding (error)

import           Data.Aeson

import           Error.Definition

import           Route.Common.ToJSONOptions

newtype ErrorPresenter = ErrorPresenter {
    _message :: Text
} deriving (Show, Generic)

instance ToJSON ErrorPresenter where
    toJSON = genericToJSON crosscropToJSONOptions

makeErrorPresenter :: Error -> ErrorPresenter
makeErrorPresenter error = ErrorPresenter errorMessage
    where
        errorMessage = tshow error::Text

