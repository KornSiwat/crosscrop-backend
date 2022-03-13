module Helper.Request where

import           Import

import           Data.Aeson

import           Error.Definition

parseJSONBody :: FromJSON a => Handler (Either Error a)
parseJSONBody = do
    parsingResult <- parseCheckJsonBody :: FromJSON a => Handler (Result a)

    case parsingResult of
        Success x -> return $ Right x
        Error _   -> return $ Left ToBeDefinedError
