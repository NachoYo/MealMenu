//
//  APIServiceResult.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

public enum APIServiceResult<T: Codable, Error> {
  case success(T)
  case failure(APIServiceError)
}
