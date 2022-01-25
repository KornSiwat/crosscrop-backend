{-# LANGUAGE TemplateHaskell #-}

module Model.Workflow.Common.Attribute where

import           Control.Lens (makeFieldsNoPrefix)

-- Workflow Attributes
newtype WorkflowId =
    WorkflowId String
    deriving (Show, Eq)

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
