//
//  CategoryDashboardInteractor.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class CategoryDashboardInteractor: CategoryDashboardInteractorProtocol {

  // MARK: - VIPER Variables
  weak var presenter: CategoryDashboardPresenterProtocol?
  var APIDataManager: CategoryDashboardAPIDataManagerProtocol?

  // MARK: - Presenter -> Interactor Functions
  func fetchCategories() {
    APIDataManager?.fetchCategoryService(completionHandler: { result in
      switch result {
      case .success(let catalog):
        // Sort Catalog Alphabetically
        var sortedCatalog: MealCategoryCatalog = catalog
        sortedCatalog.categories = catalog.categories.sorted(by: {
          $0.strCategory < $1.strCategory
        })
        self.presenter?.didFetchCatalog(catalog: catalog)
      case .failure(_):
        // Error
        break
      }
    })
  }

  func fetchCategoryImages(catalog: MealCategoryCatalog, completionHandler: @escaping ([String: UIImage?]) -> Void) {
    let group: DispatchGroup = DispatchGroup()
    var imageCatalog: [String: UIImage?] = [:]
    for category in catalog.categories {
      group.enter()
      APIDataManager?.fetchCategoryImage(downloadURL: category.strCategoryThumb, completionHandler: { data in
        imageCatalog[category.idCategory] = UIImage(data: data ?? Data())
        group.leave()
      })
    }
    group.notify(queue: DispatchQueue.main, execute: {
      completionHandler(imageCatalog)
    })
  }
}
