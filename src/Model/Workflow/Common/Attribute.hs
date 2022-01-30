{-# LANGUAGE TemplateHaskell #-}

module Model.Workflow.Common.Attribute where

import           Control.Lens         (makeFieldsNoPrefix)
import           Database.Persist.Sql

import           Class.ToKey
import           Helper.Converter

-- Workflow Attributes
newtype WorkflowId =
    WorkflowId Int
    deriving (Show, Eq)

instance ToKey WorkflowId where
  toKey (WorkflowId x) =  toSqlKey . intToInt64 $ x

-- Season Attributes
newtype SeasonNo =
    SeasonNo Int
    deriving (Show, Eq)

newtype Year =
    Year Int
    deriving (Show, Eq)

data Season =
    Season
        { seasonNo :: SeasonNo
        , year     :: Year
        }
    deriving (Show, Eq)

makeSeason :: SeasonNo -> Year -> Season
makeSeason = Season

makeFieldsNoPrefix ''Season
