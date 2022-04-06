module Route.Workflow.Common.WorkflowPresenter.Factory where

import           Control.Lens

import qualified Model.Workflow                                     as M

import qualified Route.Germplasm.Common.Presenter                   as P.GP
import qualified Route.Season.Common.Presenter                      as P.SS
import           Route.Workflow.Common.WorkflowPresenter.Definition

fromWorkflow :: M.Workflow
             -> WorkflowPresenter
fromWorkflow x = WorkflowPresenter {
    _id = x^.M.id,
    _workflowType = x^.M.workflowType,
    _name = x^.M.name,
    _germplasms = map P.GP.fromGermplasm (x^.M.germplasms),
    _season = P.SS.fromSeason $ x^.M.season,
    _createdOn = x^.M.createdOn,
    _updatedOn = x^.M.updatedOn
}
