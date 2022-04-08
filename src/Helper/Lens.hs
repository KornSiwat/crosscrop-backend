{-# LANGUAGE NoImplicitPrelude #-}

module Helper.Lens where

import           ClassyPrelude.Yesod

import           Control.Lens

(.~?) :: ASetter s t a b
      -> Either e b
      -> s
      -> Either e t
(.~?) x y = case y of
    Right y' -> Right <$> set x y'
    Left e   -> (\_ -> Left e)

(&^.) :: Either e s
      -> Getting a s a
      -> Either e a
x &^. y = case x of
    Right x' -> Right $ x'^.y
    Left e   -> Left e
