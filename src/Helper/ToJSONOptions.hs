module Helper.ToJSONOptions where

import           Data.Aeson

crosscropToJSONOptions :: Options
crosscropToJSONOptions = defaultOptions {
        fieldLabelModifier = drop 1
    ,   omitNothingFields = True
    }
