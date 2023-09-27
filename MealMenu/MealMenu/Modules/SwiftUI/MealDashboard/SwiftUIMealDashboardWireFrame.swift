//
//  SwiftUIMealDashboardWireFrame.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Foundation
import UIKit
import SwiftUI

final class SwiftUIMealDashboardWireFrame {

  // MARK: - Module Presentation
  static func presentCategoryDashboardModule(category: MealCategory) -> some View {
    let viewModel: MealDashboardViewModel = MealDashboardViewModel(mealCategory: category.strCategory)
    let view: SwiftUIMealDashboardView = SwiftUIMealDashboardView(viewModel: viewModel, mealCategory: category.strCategory)
    return view
  }
}
