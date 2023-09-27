//
//  HTTPMethod.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
  /// `DELETE` method.
  public static let delete: HTTPMethod = HTTPMethod(rawValue: "DELETE")
  /// `GET` method.
  public static let get: HTTPMethod = HTTPMethod(rawValue: "GET")
  /// `PATCH` method.
  public static let patch: HTTPMethod = HTTPMethod(rawValue: "PATCH")
  /// `POST` method.
  public static let post: HTTPMethod = HTTPMethod(rawValue: "POST")
  /// `PUT` method.
  public static let put: HTTPMethod = HTTPMethod(rawValue: "PUT")

  public let rawValue: String

  // MARK: - Initializer
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}
