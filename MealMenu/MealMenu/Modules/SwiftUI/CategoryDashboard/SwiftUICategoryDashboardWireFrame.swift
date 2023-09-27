//
//  SwiftUICategoryDashboardWireFrame.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 25/09/23.
//

import Foundation
import UIKit
import SwiftUI

final class SwiftUICategoryDashboardWireFrame {

  // MARK: - Module Presentation
  static func presentCategoryDashboardModule() -> UIViewController {
    let viewModel: CategoryDashboardViewModel = CategoryDashboardViewModel()
    let view: SwiftUICategoryDashboardView = SwiftUICategoryDashboardView(viewModel: viewModel)
    let hostingViewController: UIHostingController = UIHostingController(rootView: view)
    return hostingViewController
  }
}
