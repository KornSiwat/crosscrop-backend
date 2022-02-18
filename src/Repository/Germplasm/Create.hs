{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE NamedFieldPuns         #-}
{-# LANGUAGE NoImplicitPrelude      #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module Repository.Germplasm.Create where

import           Import

import           Control.Lens

import           Class.ToPersistKey
import           Model.Germplasm.Common.Attribute (Attributes,
                                                   GermplasmName (..))
import           Model.Germplasm.Common.Factory
import           Model.Workflow.Common.Attribute  (WorkflowId (..))
import           Persist.Entity
import           Persist.Field.JsonB

data CreateGermplasmArgs =
  CreateGermplasmArgs
  { _createGermplasmArgsName       :: GermplasmName
  , _createGermplasmArgsWorkflowId :: Maybe WorkflowId
  , _createGermplasmArgsAttributes :: Attributes
  }

makeFields ''CreateGermplasmArgs

createGermplasmArgs :: CreateGermplasmArgs
createGermplasmArgs = CreateGermplasmArgs (GermplasmName "") Nothing emptyAttributes

createGermplasm :: CreateGermplasmArgs -> Handler (Key GermplasmEntity)
createGermplasm args = do
    currentTime <- liftIO getCurrentTime

    let (GermplasmName name') = args^.name
    let workflowId' =  toKey <$> args^.workflowId
    let attributes' = JsonB $ toJSON $ args^.attributes
    let createdOn = currentTime
    let updatedOn = Nothing
    let deletedOn = Nothing
    let entity = GermplasmEntity name' attributes' workflowId' createdOn updatedOn deletedOn

    runDB $ insert entity
