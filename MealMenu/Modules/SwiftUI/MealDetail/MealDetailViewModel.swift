//
//  MealDetailViewModel.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Foundation
import SwiftUI
import Combine

class MealDetailViewModel: ObservableObject {

  // MARK: - Initializer
  public init(mealItem: MealItem) {
    self.mealItem = mealItem
  }

  // MARK: - Variables
  let mealItem: MealItem
  @Published var showGrid: Bool = false
  @Published var mealDetail: MealDetail? = nil
  @Published var mealIngredients: [MealIngredient] = []

  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  // MARK: - Functions
  func fetchMealDetail() {
    let mealDetailUseCase: MealDetailUseCase = MealDetailUseCase()
    mealDetailUseCase.execute(idMeal: mealItem.idMeal)
      .receive(on: DispatchQueue.main)
      .sink { _ in
        // Error
      } receiveValue: { mealArray in
        if let mealDetail: MealDetail = mealArray.meals.first {
          self.mealDetail = mealDetail
          self.processMealDetail(mealDetail: mealDetail)
        }
      }
      .store(in: &cancellables)
  }

  func processMealDetail(mealDetail: MealDetail) {
    if let mealDetailDictionary = try? mealDetail.asDictionary() {
      for index in 1...20 {
        let ingredientKey: String = "strIngredient\(index)"
        let ingredientSizeKey: String = "strMeasure\(index)"
        if let ingredient: String = mealDetailDictionary[ingredientKey] as? String,
           ingredient != "",
           ingredient != " " {
          let ingredientMeasure: String? = mealDetailDictionary[ingredientSizeKey] as? String
          let mealIngredient: MealIngredient = MealIngredient(ingredientName: ingredient, ingredientMeasure: ingredientMeasure)
          self.mealIngredients.append(mealIngredient)
        }
      }
    }
    self.showGrid = true
  }
}

struct MealIngredient: Identifiable {
  let ingredientName: String
  let ingredientMeasure: String?

  public var id: UUID {
    return UUID()
  }
}
