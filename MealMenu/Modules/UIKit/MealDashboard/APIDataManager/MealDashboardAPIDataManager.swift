//
//  CategoryDashboardAPIDataManager.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation

class MealDashboardAPIDataManager: MealDashboardAPIDataManagerProtocol {

  // MARK: - Variables and Constants
  private let apiClient: APIClient = APIClient()
  let stringQueryNameString: String = "c"

  // MARK: - Functions
  func fetchMealsCatalog(mealCategory: String, completionHandler: @escaping (APIServiceResult<MealList, APIServiceError>) -> Void) {
    var service: FetchMealsByCategoryService = FetchMealsByCategoryService()
    let queryParameters = URLQueryItem(name: stringQueryNameString, value: mealCategory)
    service.queryParameters = [queryParameters]
    apiClient.perform(service: service, completion: completionHandler)
  }

  func fetchMealImage(downloadURL: String, completionHandler: @escaping (Data?) -> Void) {
    apiClient.directDownload(downloadPath: downloadURL) { data in
      completionHandler(data)
    }
  }
}
