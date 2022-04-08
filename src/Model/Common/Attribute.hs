module Model.Common.Attribute where

import           Import

newtype CreatedOn =
    CreatedOn UTCTime
    deriving (Show, Eq)

instance ToJSON CreatedOn where
  toJSON (CreatedOn x) = toJSON x

newtype UpdatedOn =
    UpdatedOn UTCTime
    deriving (Show, Eq)

instance ToJSON UpdatedOn where
  toJSON (UpdatedOn x) = toJSON x

newtype DeletedOn =
    DeletedOn UTCTime
    deriving (Show, Eq)

instance ToJSON DeletedOn where
  toJSON (DeletedOn x) = toJSON x
