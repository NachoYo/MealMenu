//
//  CategoryDashboardInteractor.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDetailInteractor: MealDetailInteractorProtocol {

  // MARK: - VIPER Variables
  var presenter: MealDetailPresenterProtocol?
  var APIDataManager: MealDetailAPIDataManagerProtocol?

  // MARK: - Presenter -> Interactor Functions
  func fetchMealDetail(idMeal: String) {
    APIDataManager?.fetchMealDetailService(idMeal: idMeal, completionHandler: { result in
      switch result {
      case .success(let mealArray):
        if let mealDetail: MealDetail = mealArray.meals.first {
          self.presenter?.didFetchMealDetail(mealDetail: mealDetail)
        } else {
          self.presenter?.failedMealDetailFetch()
        }
      case .failure(_):
        self.presenter?.failedMealDetailFetch()
      }
    })
  }
}
