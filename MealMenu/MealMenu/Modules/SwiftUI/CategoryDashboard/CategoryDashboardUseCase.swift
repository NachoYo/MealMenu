//
//  CategoryDashboardUseCase.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 25/09/23.
//

import Combine

struct CategoryDashboardUseCase {

  // MARK: - Execute Case
  func execute() -> AnyPublisher<MealCategoryCatalog, APIServiceError> {
    let apiClient: APIClient = APIClient()
    let service: FetchCategoriesService = FetchCategoriesService()
    let cancellable: AnyPublisher<Response<MealCategoryCatalog>, APIServiceError>
    cancellable = apiClient.perform(service: service)
    return cancellable
      .map(\.value)
      .mapError { error -> APIServiceError in
        error as APIServiceError
      }
      .eraseToAnyPublisher()
  }
}
