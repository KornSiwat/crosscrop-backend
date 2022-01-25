{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE TemplateHaskell        #-}

module Model.Workflow.BreedingNursery where

import           Control.Lens                    (makeFieldsNoPrefix)

import           Model.Germplasm.BreedingNursery (BreedingNurseryGermplasm)
import           Model.Workflow.Common.Attribute (Season,
                                                  WorkflowId (WorkflowId))

-- BreedingNursery
data BreedingNursery =
    BreedingNursery
        { _id         :: WorkflowId
        , _season     :: Season
        , _germplasms :: [BreedingNurseryGermplasm]
        }
    deriving (Show, Eq)

makeFieldsNoPrefix ''BreedingNursery

makeBreedingNursery :: WorkflowId -> Season -> [BreedingNurseryGermplasm] -> BreedingNursery
makeBreedingNursery = BreedingNursery
