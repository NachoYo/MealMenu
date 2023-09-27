//
//  APIServiceError.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation

public enum APIServiceError: Error {
  case noNetwork
  case timeout
  case generic(Error)
  case parserError
  case unknown
}
