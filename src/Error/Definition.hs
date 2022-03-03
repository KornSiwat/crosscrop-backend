module Error.Definition where

data Error
    = ToBeDefinedError
    | RecordNotFound String Int
    | InvalidForm
    | Unauthorized
    deriving (Show, Eq)
