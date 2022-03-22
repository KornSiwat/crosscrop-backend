module Route.Common.ToJSONOptions where

import           Data.Aeson

crosscropToJSONOptions :: Options
crosscropToJSONOptions = defaultOptions {
        fieldLabelModifier = camelTo2 '_' . drop 1
    ,   omitNothingFields = True
    }

