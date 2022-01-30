{-# LANGUAGE TemplateHaskell #-}

module Request.Germplsm where

import           Control.Lens
import           Data.Text

data CreateGermplasmRequestBody = CreateGermplasmRequestBody {
    _name       :: Text,
    _workflowId :: Maybe Int
    _attributes :: [(Text)]
}

instance FromJSON [Entry] where
  parseJSON x =
    parseJSON x >>= mapM parseEntry . toList

parseEntry :: (String, Value) -> Parser Entry
parseEntry (i, v) =
  withObject "entry body" (\ o ->
    Entry i <$> o .: "name" <*> o .: "location")
    v

makeFields ''CreateGermplasmRequestBody
