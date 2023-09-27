//
//  MealList.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 16/09/23.
//

import Foundation

public struct MealList: Codable {
  public var meals: [MealItem]
}

public struct MealItem: Codable {
  public let strMeal: String
  public let strMealThumb: String
  public let idMeal: String
}

extension MealItem: Identifiable {
  public var id: UUID {
    return UUID()
  }
}
