module Service.CrossingMethod where

import           Model.Germplasm.BreedingNursery (BreedingNurseryGermplasm)
import           Model.Germplasm.CrossingBlock   (CrossingBlockGermplasm)

type CrossingMethod = ([BreedingNurseryGermplasm] -> [CrossingBlockGermplasm])

normalCross :: CrossingMethod
normalCross = undefined

specialCross :: CrossingMethod
specialCross = undefined
