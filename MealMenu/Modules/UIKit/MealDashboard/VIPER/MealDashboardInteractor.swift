//
//  CategoryDashboardInteractor.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDashboardInteractor: MealDashboardInteractorProtocol {

  // MARK: - VIPER Variables
  weak var presenter: MealDashboardPresenterProtocol?
  var APIDataManager: MealDashboardAPIDataManagerProtocol?

  // MARK: - Presenter -> Interactor Functions
  func fetchMeals(mealCategory: String) {
    APIDataManager?.fetchMealsCatalog(mealCategory: mealCategory, completionHandler: { result in
      switch result {
      case .success(let list):
        // Sort List Alphabetically
        var sortedList: MealList = list
        sortedList.meals = list.meals.sorted(by: {
          $0.strMeal < $1.strMeal
        })
        self.presenter?.didFetchCatalog(list: sortedList)
      case .failure(_):
        // Error
        break
      }
    })
  }

  func fetchMealImages(list: MealList, completionHandler: @escaping ([String: UIImage?]) -> Void) {
    let group: DispatchGroup = DispatchGroup()
    var imageCatalog: [String: UIImage?] = [:]
    for category in list.meals {
      group.enter()
      APIDataManager?.fetchMealImage(downloadURL: category.strMealThumb, completionHandler: { data in
        imageCatalog[category.idMeal] = UIImage(data: data ?? Data())
        group.leave()
      })
    }
    group.notify(queue: DispatchQueue.main, execute: {
      completionHandler(imageCatalog)
    })
  }
}
