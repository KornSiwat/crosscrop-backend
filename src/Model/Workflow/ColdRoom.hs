{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.ColdRoom where

import           Control.Lens                    (makeFieldsNoPrefix)

import           Model.Germplasm.ColdRoom        (ColdRoomGermplasm)
import           Model.Workflow.Common.Attribute (WorkflowId)

-- ColdRoom
data ColdRoom =
    ColdRoom
        { _id         :: WorkflowId
        , _germplasms :: [ColdRoomGermplasm]
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''ColdRoom

makeColdRoom :: WorkflowId -> [ColdRoomGermplasm] -> ColdRoom
makeColdRoom = ColdRoom
