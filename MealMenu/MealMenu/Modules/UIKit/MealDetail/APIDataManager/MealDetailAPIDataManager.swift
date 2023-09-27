//
//  CategoryDashboardAPIDataManager.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation

class MealDetailAPIDataManager: MealDetailAPIDataManagerProtocol {

  // MARK: - Variables and Constants
  private let apiClient: APIClient = APIClient()
  let stringQueryNameString: String = "i"

  // MARK: - Functions
  func fetchMealDetailService(idMeal: String, completionHandler: @escaping (APIServiceResult<MealDetailArray, APIServiceError>) -> Void) {
    var service: FetchMealDetailService = FetchMealDetailService()
    let queryParameters: URLQueryItem = URLQueryItem(name: stringQueryNameString, value: idMeal)
    service.queryParameters = [queryParameters]
    apiClient.perform(service: service, completion: completionHandler)
  }
}
