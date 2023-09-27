//
//  ServiceParameters.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public protocol ServiceParameters {
  var httpMethod: HTTPMethod { get }
  var queryParameters: [URLQueryItem]? { get set }
  var headers: HTTPHeaders? { get }
  var timeoutInterval: TimeInterval { get }
  var servicePath: String { get }
}
