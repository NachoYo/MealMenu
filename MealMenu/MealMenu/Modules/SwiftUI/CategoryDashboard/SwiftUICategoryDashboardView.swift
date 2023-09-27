//
//  SwiftUICategoryDashboardView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 25/09/23.
//

import SwiftUI

struct SwiftUICategoryDashboardView<ViewModel: CategoryDashboardViewModel>: View {

  // MARK: - Initializer
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Variables
  @ObservedObject var viewModel: ViewModel

  // MARK: - UI Constants
  let categoryViewHeight: CGFloat = 250.0
  let textHeight: CGFloat = 40.0
  let textPadding: CGFloat = 40.0
  let loaderScaleEffect: CGFloat = 2.0
  let mainTitleFontSize: CGFloat = 26.0
  let uberFontString: String = "UberMoveMedium"

  // MARK: - Views
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          Text("Welcome!")
            .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
            .padding(textPadding)
            .font(.custom(uberFontString, size: mainTitleFontSize))
          if viewModel.showGrid {
            scrollView
          } else {
            ProgressView()
              .progressViewStyle(.circular)
              .scaleEffect(loaderScaleEffect)
              .frame(maxHeight: .infinity)
          }
        }
      }
      .onAppear {
        viewModel.fetchCategories()
      }
    }
  }

  var scrollView: some View {
    ScrollView {
      VStack {
        ForEach(Int.zero...calculateRows() - 1, id: \.self) { row in
          mealCategoryCell(row: row)
        }
      }
    }
    .padding()
  }

  func mealCategoryCell(row: Int) -> some View {
    HStack {
      ZStack {
        CategoryView(category: viewModel.mealCategories[row * 2])
          .frame(height: categoryViewHeight)
        NavigationLink {
          SwiftUIMealDashboardWireFrame.presentCategoryDashboardModule(category: viewModel.mealCategories[row * 2])
        } label: {
          RoundedRectangle(cornerRadius: CGFloat.zero)
            .fill(.clear)
        }
      }
      ZStack {
        if row * 2 + 1 < viewModel.mealCategories.count {
          CategoryView(category: viewModel.mealCategories[row * 2 + 1])
            .frame(height: categoryViewHeight)
          NavigationLink {
            SwiftUIMealDashboardWireFrame.presentCategoryDashboardModule(category: viewModel.mealCategories[row * 2])
          } label: {
            RoundedRectangle(cornerRadius: CGFloat.zero)
              .fill(.clear)
          }
        } else {
          RoundedRectangle(cornerRadius: CGFloat.zero)
            .fill(.clear)
        }
      }
    }
  }

  // MARK: - Functions
  func calculateRows() -> Int {
    let numberOfRows: Int = (viewModel.mealCategories.count + 1) / 2
    return numberOfRows
  }
}
