{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.YieldTrial where

import           Control.Lens                    (makeFieldsNoPrefix)

import           Model.Germplasm.YieldTrial      (YieldTrialGermplasm)
import           Model.Workflow.Common.Attribute (Season, WorkflowId)

-- YieldTrial
data YieldTrial =
    YieldTrial
        { _id         :: WorkflowId
        , _season     :: Season
        , _germplasms :: [YieldTrialGermplasm]
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''YieldTrial

makeYieldTrial :: WorkflowId -> Season -> [YieldTrialGermplasm] -> YieldTrial
makeYieldTrial = YieldTrial
