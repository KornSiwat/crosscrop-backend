module Service.BreedingNursery where

import           Error.Definition                 (Error)

import           Model.Germplasm.BreedingNursery  (BreedingNurseryGermplasm)
import           Model.Germplasm.ColdRoom         (ColdRoomGermplasm)
import           Model.Germplasm.Common.Attribute (GermplasmId)
import           Model.Workflow.BreedingNursery   (BreedingNursery)
import           Model.Workflow.Common.Attribute  (Season)

fromColdRoom :: [ColdRoomGermplasm] -> Season -> BreedingNursery
fromColdRoom = undefined

fromBreedingNursery :: [BreedingNurseryGermplasm] -> Season -> BreedingNursery
fromBreedingNursery = undefined

withdraw ::
     [GermplasmId]
  -> BreedingNursery
  -> Either Error [BreedingNurseryGermplasm]
withdraw = undefined
