//
//  FetchCategoriesService.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 15/09/23.
//
import Foundation

struct FetchCategoriesService: ServiceParameters {
  var queryParameters: [URLQueryItem]?

  var httpMethod: HTTPMethod = .get

  var headers: HTTPHeaders? = nil

  var timeoutInterval: TimeInterval = 60.0

  var servicePath: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
}
