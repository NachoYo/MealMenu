//
//  CategoryDashboardViewModel.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 25/09/23.
//

import SwiftUI
import Combine
import UIKit

class CategoryDashboardViewModel: ObservableObject {

  // MARK: - Variables
  @Published var showGrid: Bool = false
  @Published var mealCategoryListView: Bool = false
  @Published var mealCategories: [MealCategory] = []

  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  // MARK: - Functions
  func fetchCategories() {
    let categoryUseCase: CategoryDashboardUseCase = CategoryDashboardUseCase()
    categoryUseCase.execute()
      .receive(on: DispatchQueue.main)
      .sink { _ in
        // Error
      } receiveValue: { mealCatalog in
        // Sort Catalog Alphabetically
        var sortedCatalog: MealCategoryCatalog = mealCatalog
        sortedCatalog.categories = mealCatalog.categories.sorted(by: {
          $0.strCategory < $1.strCategory
        })

        self.mealCategories = sortedCatalog.categories
        self.showGrid = true
      }
      .store(in: &cancellables)
  }
}
