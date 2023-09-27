//
//  MealDashboardWireFrame.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDetailWireFrame: MealDetailWireFrameProtocol {

  // MARK: - Module Presentation
  static func presentMealDetailModule(meal: MealItem, image: UIImage?) -> UIViewController {
    // Generating module components
    let view: MealDetailViewProtocol = MealDetailViewController()
    let presenter: MealDetailPresenter = MealDetailPresenter(mealItem: meal, image: image)
    var interactor: MealDetailInteractorProtocol = MealDetailInteractor()
    let APIDataManager: MealDetailAPIDataManagerProtocol = MealDetailAPIDataManager()
    // Connecting
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    interactor.presenter = presenter
    interactor.APIDataManager = APIDataManager

    return view
  }
}
