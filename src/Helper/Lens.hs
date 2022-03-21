{-# LANGUAGE NoImplicitPrelude #-}

module Helper.Lens where

import Import

import Control.Lens

(.~?) :: ASetter s t a b -> Either e b -> s -> Either e t
(.~?) x y = case y of 
    Right y' -> Right <$> set x y'
    Left e -> (\_ -> Left e)

