{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}

module Persist.Field.JsonB where

import qualified Data.Aeson                          as A
import           Data.Aeson.Parser                   (value)
import qualified Data.Attoparsec.ByteString.Char8    as AP

import           Data.ByteString.Lazy
import           Data.Text                           as T (pack)
import           Database.Persist.Class.PersistField (PersistField (fromPersistValue))
import           Database.Persist.Postgresql         (LiteralType (Escaped),
                                                      PersistField (toPersistValue),
                                                      PersistFieldSql (sqlType),
                                                      PersistValue (PersistByteString, PersistLiteral_),
                                                      SqlType (SqlOther))


newtype JsonB =
  JsonB A.Value
  deriving (Show, Eq)

instance PersistField JsonB where
  toPersistValue (JsonB t) = PersistLiteral_ Escaped $ toStrict $ A.encode t
  fromPersistValue (PersistByteString s) =
    either (Left . T.pack . ("Could not convert Json " ++)) (Right . JsonB) $
    AP.eitherResult $ AP.parse value s
  fromPersistValue a =
    Left $ T.pack ("JsonB conversion failed for value " ++ show a)

instance PersistFieldSql JsonB where
  sqlType _ = SqlOther "jsonb"

empty :: JsonB
empty = JsonB A.Null
