module Model.Germplasm.Common.Attribute where

import           Data.Map  (Map)
import           Data.Time (Day, UTCTime)


-- Basic Attributes
newtype GermplasmId =
    GermplasmId String
    deriving (Show, Eq)

newtype GermplasmName =
    GermplasmName String
    deriving (Show, Eq)

newtype AttributeName =
    AttributeName String
    deriving (Show, Eq, Ord)

data AttributeValue
    = AttributeString String
    | AttributeInt Int
    | AttributeNumber Double
    | AttributeBool Bool
    | AttributeDateTime UTCTime
    | AttributeDate Day
    deriving (Show, Eq)

type Attributes = Map AttributeName AttributeValue

-- Specific Attributes
newtype GermplasmCount =
    GermplasmCount Int
    deriving (Show, Eq)

newtype Plot =
    Plot String
    deriving (Show, Eq)
