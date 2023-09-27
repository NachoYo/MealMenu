//
//  MealDashboardWireFrame.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDashboardWireFrame: MealDashboardWireFrameProtocol {

  // MARK: - Module Presentation
  static func presentMealDashboardModule(mealCategory: String) -> UIViewController {
    // Generating module components
    let view: MealDashboardViewProtocol = MealDashboardViewController()
    let presenter: MealDashboardPresenterProtocol = MealDashboardPresenter(mealCategory: mealCategory)
    var interactor: MealDashboardInteractorProtocol = MealDashboardInteractor()
    let APIDataManager: MealDashboardAPIDataManagerProtocol = MealDashboardAPIDataManager()
    let wireFrame: MealDashboardWireFrameProtocol = MealDashboardWireFrame()

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
