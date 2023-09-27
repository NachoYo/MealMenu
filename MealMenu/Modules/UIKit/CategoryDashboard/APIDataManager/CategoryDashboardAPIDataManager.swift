//
//  CategoryDashboardAPIDataManager.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation

class CategoryDashboardAPIDataManager: CategoryDashboardAPIDataManagerProtocol {

  // MARK: - Variables
  private let apiClient: APIClient = APIClient()

  // MARK: - Functions
  func fetchCategoryService(completionHandler: @escaping (APIServiceResult<MealCategoryCatalog, APIServiceError>) -> Void) {
    apiClient.perform(service: FetchCategoriesService(), completion: completionHandler)
  }

  func fetchCategoryImage(downloadURL: String, completionHandler: @escaping (Data?) -> Void) {
    apiClient.directDownload(downloadPath: downloadURL) { data in
      completionHandler(data)
    }
  }
}
