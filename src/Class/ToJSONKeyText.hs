module Class.ToJSONKeyText where

import           Data.Text

class ToJSONKeyText a where
    toJSONKeyText :: a -> Text

