//
//  FetchMealsByCategoryService.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 16/09/23.
//

import Foundation

struct FetchMealsByCategoryService: ServiceParameters {
  
  var queryParameters: [URLQueryItem]? = nil

  var httpMethod: HTTPMethod = .get

  var headers: HTTPHeaders? = nil

  var timeoutInterval: TimeInterval = 60.0

  var servicePath: String = "https://themealdb.com/api/json/v1/1/filter.php"
}
