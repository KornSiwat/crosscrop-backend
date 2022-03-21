{-# LANGUAGE NoImplicitPrelude #-}

module Helper.Lens where

import Import

import Control.Lens

import Error.Definition

(.~?) :: ASetter s t a b -> Either Error b -> s -> Either Error t
(.~?) x y = case y of 
    Right y' -> Right <$> set x y'
    Left e -> (\_ -> Left e)

