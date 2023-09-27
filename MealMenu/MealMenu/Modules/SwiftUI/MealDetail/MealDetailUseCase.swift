//
//  MealDetailUseCase.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Combine
import Foundation

struct MealDetailUseCase {

  // MARK: - Constants
  let stringQueryNameString: String = "i"

  // MARK: - Execute Case
  func execute(idMeal: String) -> AnyPublisher<MealDetailArray, APIServiceError> {
    let apiClient: APIClient = APIClient()
    var service: FetchMealDetailService = FetchMealDetailService()
    let queryParameters: URLQueryItem = URLQueryItem(name: stringQueryNameString, value: idMeal)
    service.queryParameters = [queryParameters]
    let cancellable: AnyPublisher<Response<MealDetailArray>, APIServiceError>
    cancellable = apiClient.perform(service: service)
    return cancellable
      .map(\.value)
      .mapError { error -> APIServiceError in
        error as APIServiceError
      }
      .eraseToAnyPublisher()
  }
}
