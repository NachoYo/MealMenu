//
//  MealDashboardUseCase.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Combine
import Foundation

struct MealDashboardUseCase {

  // MARK: - Constants
  let stringQueryNameString: String = "c"

  // MARK: - Execute Case
  func execute(mealCategory: String) -> AnyPublisher<MealList, APIServiceError> {
    let apiClient: APIClient = APIClient()
    var service: FetchMealsByCategoryService = FetchMealsByCategoryService()
    let queryParameters = URLQueryItem(name: stringQueryNameString, value: mealCategory)
    service.queryParameters = [queryParameters]
    let cancellable: AnyPublisher<Response<MealList>, APIServiceError>
    cancellable = apiClient.perform(service: service)
    return cancellable
      .map(\.value)
      .mapError { error -> APIServiceError in
        error as APIServiceError
      }
      .eraseToAnyPublisher()
  }
}
