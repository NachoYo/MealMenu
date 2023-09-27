//
//  MealDashboardViewModel.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Foundation
import SwiftUI
import Combine

class MealDashboardViewModel: ObservableObject {

  // MARK: - Initializer
  public init(mealCategory: String) {
    self.mealCategory = mealCategory
  }

  // MARK: - Variables
  private let mealCategory: String
  @Published var showGrid: Bool = false
  @Published var mealListView: Bool = false
  @Published var mealList: [MealItem] = []

  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  // MARK: - Functions
  func fetchMeals() {
    let mealList = MealDashboardUseCase()
    mealList.execute(mealCategory: mealCategory)
      .receive(on: DispatchQueue.main)
      .sink { _ in
        // Error
      } receiveValue: { mealList in
        // Sort Meals Alphabetically
        var sortedList: MealList = mealList
        sortedList.meals = mealList.meals.sorted(by: {
          $0.strMeal < $1.strMeal
        })

        self.mealList = sortedList.meals
        self.showGrid = true
      }
      .store(in: &cancellables)
  }
}
