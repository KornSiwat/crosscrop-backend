{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Common.GermplasmPresenter.Definition where

import           Import

import           Data.Aeson

import           Route.Common.ToJSONOptions
import Model.Germplasm

data GermplasmPresenter = GermplasmPresenter
    { _id         :: GermplasmId
    , _name       :: GermplasmName
    , _attributes :: Attributes
    , _createdOn  :: CreatedOn 
    , _updatedOn  :: Maybe UpdatedOn
    } deriving (Show, Generic)

instance ToJSON GermplasmPresenter where
    toJSON = genericToJSON crosscropToJSONOptions

