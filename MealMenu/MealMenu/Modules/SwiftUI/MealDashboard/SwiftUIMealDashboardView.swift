//
//  SwiftUIMealDashboardView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

struct SwiftUIMealDashboardView<ViewModel: MealDashboardViewModel>: View {

  // MARK: - Initializer
  init(viewModel: ViewModel, mealCategory: String) {
    self.viewModel = viewModel
    self.mealCategory = mealCategory
  }

  private let mealCategory: String
  @ObservedObject var viewModel: ViewModel

  // MARK: - UI Constants
  let mealViewHeight: CGFloat = 250.0
  let textHeight: CGFloat = 40.0
  let loaderScaleEffect: CGFloat = 2.0
  let mainTitleFontSize: CGFloat = 26.0
  let uberFontString: String = "UberMoveMedium"

  // MARK: - Views
  var body: some View {
    ZStack {
      VStack {
        Text("Choose your meal")
          .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
          .padding(16)
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
      viewModel.fetchMeals()
    }
    .navigationBarTitle(mealCategory, displayMode: .inline)
  }

  var scrollView: some View {
    ScrollView {
      VStack {
        ForEach(Int.zero...calculateRows() - 1, id: \.self) { row in
          mealViewCell(row: row)
        }
      }
      .padding()
    }
  }

  func mealViewCell(row: Int) -> some View {
    HStack {
      ZStack {
        MealView(mealItem: viewModel.mealList[row * 2])
          .frame(height: mealViewHeight)
        NavigationLink {
          SwiftUIMealDetailWireFrame.presentCategoryDashboardModule(mealItem: viewModel.mealList[row * 2])
        } label: {
          RoundedRectangle(cornerRadius: CGFloat.zero)
            .fill(.clear)
        }
      }
      if row * 2 + 1 < viewModel.mealList.count {
        ZStack {
          MealView(mealItem: viewModel.mealList[row * 2 + 1])
            .frame(height: mealViewHeight)
          NavigationLink {
            SwiftUIMealDetailWireFrame.presentCategoryDashboardModule(mealItem: viewModel.mealList[row * 2 + 1])
          } label: {
            RoundedRectangle(cornerRadius: CGFloat.zero)
              .fill(.clear)
          }
        }
      } else {
        RoundedRectangle(cornerRadius: CGFloat.zero)
          .fill(.clear)
      }
    }
  }

  func calculateRows() -> Int {
    let numberOfRows: Int = (viewModel.mealList.count + 1) / 2
    return numberOfRows
  }
}
