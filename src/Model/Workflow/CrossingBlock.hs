{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.CrossingBlock where

import           Control.Lens                    (makeFieldsNoPrefix)

import           Model.Germplasm.CrossingBlock   (CrossingBlockGermplasm)
import           Model.Workflow.Common.Attribute (Season, WorkflowId)

-- CrossingBlock
data CrossingBlock =
    CrossingBlock
        { _id         :: WorkflowId
        , _season     :: Season
        , _germplasms :: [CrossingBlockGermplasm]
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''CrossingBlock

makeCrossingBlock :: WorkflowId -> Season -> [CrossingBlockGermplasm] -> CrossingBlock
makeCrossingBlock = CrossingBlock
