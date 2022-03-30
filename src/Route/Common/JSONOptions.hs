module Route.Common.JSONOptions where

import           Data.Aeson
import           Data.Aeson.Casing

toJSONOptions :: Options
toJSONOptions = defaultOptions {
        fieldLabelModifier = snakeCase . drop 1
    ,   omitNothingFields = True
    }

