//
//  MealCategory.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 15/09/23.
//

import Combine
import Foundation

public struct MealCategoryCatalog: Codable {
  public var categories: [MealCategory]
}

public struct MealCategory: Codable {
  public let idCategory: String
  public let strCategory: String
  public let strCategoryThumb: String
}

extension MealCategory: Identifiable {
  public var id: UUID {
    return UUID()
  }
}

