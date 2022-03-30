{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}

module Model.Workflow.Common.Attribute where

import           ClassyPrelude.Yesod

import           Class.ToPersistKey

import           Database.Persist.Sql

import           Helper.TypeConverter

-- Basic Attributes
newtype WorkflowId =
    WorkflowId Int
    deriving (Show, Read, Eq, PathPiece, FromJSON)

instance ToPersistKey WorkflowId where
  toKey (WorkflowId x) =  toSqlKey . intToInt64 $ x

instance ToJSON WorkflowId where
  toJSON (WorkflowId x) = toJSON x

newtype WorkflowName =
    WorkflowName Text
    deriving (Show, Eq, FromJSON)

instance ToJSON WorkflowName where
  toJSON (WorkflowName x) = toJSON x

