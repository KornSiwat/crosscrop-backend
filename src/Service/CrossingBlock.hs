module Service.CrossingBlock where

import           Error.Definition                 (Error)

import           Service.CrossingMethod           (CrossingMethod)

import           Model.Germplasm.BreedingNursery  (BreedingNurseryGermplasm)
import           Model.Germplasm.Common.Attribute (GermplasmId)
import           Model.Germplasm.CrossingBlock    (CrossingBlockGermplasm)
import           Model.Workflow.Common.Attribute  (Season)
import           Model.Workflow.CrossingBlock     (CrossingBlock)

fromBreedingNursery ::
     [BreedingNurseryGermplasm] -> CrossingMethod -> Season -> CrossingBlock
fromBreedingNursery = undefined

withdraw ::
     [GermplasmId] -> CrossingBlock -> Either Error [CrossingBlockGermplasm]
withdraw = undefined
