module Route.Workflow.Common.WorkflowPresenter.Factory where

import           Control.Lens

import qualified Model.Workflow                                       as WF

import qualified Route.Germplasm.Common.Presenter as GP
import           Route.Workflow.Common.WorkflowPresenter.Definition

fromWorkflow :: WF.Workflow -> WorkflowPresenter
fromWorkflow x = WorkflowPresenter {
    _id = x^.WF.id,
    _name = x^.WF.name,
    _germplasms = map GP.fromGermplasm (x^.WF.germplasms),
    _createdOn = x^.WF.createdOn,
    _updatedOn = x^.WF.updatedOn
}

