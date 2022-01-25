module Service.YieldTrial where

import           Error.Definition                 (Error)

import           Model.Germplasm.Common.Attribute (GermplasmId)
import           Model.Germplasm.CrossingBlock    (CrossingBlockGermplasm)
import           Model.Germplasm.YieldTrial       (YieldTrialGermplasm)
import           Model.Workflow.Common.Attribute  (Season)
import           Model.Workflow.YieldTrial        (YieldTrial)

fromCrossingBlock :: [CrossingBlockGermplasm] -> Season -> YieldTrial
fromCrossingBlock = undefined

withdraw :: [GermplasmId] -> YieldTrial -> Either Error [YieldTrialGermplasm]
withdraw = undefined
