module Repository.Germplasm where

import           Import

import           Model.Germplasm.Common.Definition (Germplasm)

getGermplasms :: Handler [Germplasm]
getGermplasms = do
    germplasmEntity <- runDB $ (selectList ([]:: [Filter GermplasmEntity]) [])

    return []
