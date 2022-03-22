{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Common.Request where

import           Import

germplasmMainAttributeNames :: [Text]
germplasmMainAttributeNames = ["id"
                              ,"name"
                              ,"workflow_id"
                              ,"created_on"
                              ,"updated_on"
                              ,"deleted_on"]

