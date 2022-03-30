module Error.Definition where

import           Data.Text

data Error
    = ToBeDefinedError
    | ToBeDefinedDBError
    | RequestBodyJSONParsingError Text
    | RecordNotFound
    | InvalidForm
    | Unauthorized
    deriving (Show, Eq)

