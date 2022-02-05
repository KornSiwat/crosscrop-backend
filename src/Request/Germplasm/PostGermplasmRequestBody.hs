{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Request.Germplasm.PostGermplasmRequestBody where

import           Control.Lens
import           Data.Aeson
import           Data.HashMap.Lazy (HashMap, delete)
import           Data.Text         (Text)

data PostGermplasmRequestBody = PostGermplasmRequestBody {
    _name       :: Text,
    _workflowId :: Maybe Int,
    _attributes ::  HashMap Text Value
} deriving (Show)

instance FromJSON PostGermplasmRequestBody where
    parseJSON = withObject "PostGermplasmRequestBody" $ parsePostGermplasmRequestBody
        where
        parsePostGermplasmRequestBody x = do
            name <- x .: "name"
            workflowId <- x .:? "workflow_id"

            let attributes = foldr delete x ["name", "workflow_id"]

            return $ PostGermplasmRequestBody name workflowId attributes

makeFieldsNoPrefix ''PostGermplasmRequestBody
