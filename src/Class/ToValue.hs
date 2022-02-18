module Class.ToValue where

import           Data.Aeson

class ToValue a where
    toValue :: a -> Value
