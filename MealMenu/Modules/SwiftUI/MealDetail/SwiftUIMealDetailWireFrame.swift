//
//  SwiftUIMealDetailWireFrame.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

final class SwiftUIMealDetailWireFrame {

  // MARK: - Module Presentation
  static func presentCategoryDashboardModule(mealItem: MealItem) -> some View {
    let viewModel: MealDetailViewModel = MealDetailViewModel(mealItem: mealItem)
    let view: SwiftUIMealDetailView = SwiftUIMealDetailView(viewModel: viewModel, mealItem: mealItem)
    return view
  }
}
