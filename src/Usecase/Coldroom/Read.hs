{-# LANGUAGE NoImplicitPrelude #-}

module Usecase.Coldroom.Read where

import           Import

import           Error.Definition

import           Model.Coldroom

import qualified Repository.Coldroom as RP

getColdroom :: Handler (Either Error Coldroom)
getColdroom = RP.getColdroom

