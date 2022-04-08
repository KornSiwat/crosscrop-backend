{-# LANGUAGE NoImplicitPrelude #-}

module Model.Season.Factory where

import           Import

import           Database.Persist.Sql

import           Error.Definition

import           Helper.TypeConverter

import           Model.Common.Attribute
import           Model.Season.Attribute
import           Model.Season.Definition

import           Persist.Entity

-- Season
makeSeason :: SeasonId
           -> Year
           -> SeasonNo
           -> CreatedOn
           -> Maybe UpdatedOn
           -> Maybe DeletedOn
           -> Either Error Season
makeSeason a b c d e f = Right $ Season a b c d e f

fromEntity :: Entity SeasonEntity
           -> Either Error Season
fromEntity seasonEntity = do
    let key = entityKey seasonEntity
    let val = entityVal seasonEntity

    let id' = seasonIdFromKey key
    let year'      = Year . seasonEntityYear $ val
    let seasonNo' = SeasonNo . seasonEntitySeasonNo $ val
    let createdOn' = CreatedOn . seasonEntityCreatedOn $ val
    let updatedOn' = UpdatedOn <$> seasonEntityUpdatedOn val
    let deletedOn' = DeletedOn <$> seasonEntityDeletedOn val

    makeSeason
            id'
            year'
            seasonNo'
            createdOn'
            updatedOn'
            deletedOn'

-- SeasonId
seasonIdFromKey :: Key SeasonEntity
                -> SeasonId
seasonIdFromKey = SeasonId . int64ToInt . fromSqlKey
