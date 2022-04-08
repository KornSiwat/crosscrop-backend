{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Common.Presenter where

import           Import                   hiding (error)

import           Data.Aeson

import           Error.Definition

import           Route.Common.JSONOptions

newtype ErrorPresenter
    = ErrorPresenter
        { _message :: Text
        }
    deriving (Show, Generic)

instance ToJSON ErrorPresenter where
    toJSON = genericToJSON toJSONOptions

makeErrorPresenter :: Error -> ErrorPresenter
makeErrorPresenter error = ErrorPresenter errorMessage
    where
        errorMessage = tshow error::Text

