module Service.ColdRoom where

import           Error.Definition                 (Error)

import           Model.Germplasm.ColdRoom         (ColdRoomGermplasm)
import           Model.Germplasm.Common.Attribute (GermplasmId)
import           Model.Workflow.ColdRoom          (ColdRoom)

withdraw :: [GermplasmId] -> ColdRoom -> Either Error [ColdRoomGermplasm]
withdraw = undefined
