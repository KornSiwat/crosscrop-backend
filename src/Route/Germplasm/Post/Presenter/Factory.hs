{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Route.Germplasm.Post.Presenter.Factory where

import           Model.Germplasm
import           Route.Germplasm.Post.Presenter.Definition

makePostGermplasmPresenter :: GermplasmId -> PostGermplasmPresenter
makePostGermplasmPresenter = PostGermplasmPresenter
