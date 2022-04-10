{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Route.Germplasm.Common.GermplasmPresenter.Definition where

import           Import

import           Data.Aeson

import           Model.Common.Attribute
import           Model.Germplasm

import           Route.Common.JSONOptions

data GermplasmPresenter
    = GermplasmPresenter
        { _id         :: GermplasmId
        , _name       :: GermplasmName
        , _attributes :: [GermplasmAttribute]
        , _createdOn  :: CreatedOn
        , _updatedOn  :: Maybe UpdatedOn
        }
    deriving (Show, Generic)

instance ToJSON GermplasmPresenter where
    toJSON = genericToJSON toJSONOptions
