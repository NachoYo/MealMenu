//
//  CategoryDashboardWireFrame.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class CategoryDashboardWireFrame: CategoryDashboardWireFrameProtocol {

  // MARK: - Module Presentation
  class func presentCategoryDashboardModule() -> UIViewController {
    // Generating module components
    let view: CategoryDashboardViewProtocol = CategoryDashboardViewController()
    let presenter: CategoryDashboardPresenterProtocol = CategoryDashboardPresenter()
    var interactor: CategoryDashboardInteractorProtocol = CategoryDashboardInteractor()
    let APIDataManager: CategoryDashboardAPIDataManagerProtocol = CategoryDashboardAPIDataManager()
    let wireFrame: CategoryDashboardWireFrameProtocol = CategoryDashboardWireFrame()

    // Connecting
    view.presenter = presenter
    presenter.view = view
    presenter.wireFrame = wireFrame
    presenter.interactor = interactor
    interactor.presenter = presenter
    interactor.APIDataManager = APIDataManager

    return view
  }
}
