{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.Common.Attribute where

import           Control.Lens         (makeFields)
import           Database.Persist.Sql

import           Class.ToPersistKey
import           Helper.TypeConverter

-- Workflow Attributes
newtype WorkflowId =
    WorkflowId Int
    deriving (Show, Eq)

instance ToPersistKey WorkflowId where
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
        { seasonSeasonNo :: SeasonNo
        , seasonYear     :: Year
        }
    deriving (Show, Eq)

makeSeason :: SeasonNo -> Year -> Season
makeSeason = Season

makeFields ''Season
