//
//  SwiftUIMealDetailView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

struct SwiftUIMealDetailView<ViewModel: MealDetailViewModel>: View {

  // MARK: - Initializer
  init(viewModel: ViewModel, mealItem: MealItem) {
    self.viewModel = viewModel
    self.mealItem = mealItem
  }

  // MARK: - Variables
  private let mealItem: MealItem
  @ObservedObject var viewModel: ViewModel

  // MARK: - UI Constants
  let imageHeight: CGFloat = 250.0
  let imageSidesPadding: CGFloat = 35.0
  let bottomPadding: CGFloat = 10.0
  let textHeight: CGFloat = 40.0
  let loaderScaleEffect: CGFloat = 2.0
  let mainTitleFontSize: CGFloat = 26.0
  let subtitleFontSize: CGFloat = 22.0
  let instructionsFontSize: CGFloat = 16.0
  let instructionsString: String = "Instructions"
  let ingredientsString: String = "Ingredients"
  let uberFontString: String = "UberMoveMedium"

  // MARK: - Views
  var body: some View {
    ZStack {
      VStack {
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
      viewModel.fetchMealDetail()
    }
    .navigationBarTitle(mealItem.strMeal, displayMode: .inline)
  }

  var scrollView: some View {
    ScrollView {
      VStack(spacing: CGFloat.zero) {
        RemoteImage(url: mealItem.strMealThumb)
          .frame(maxWidth: .infinity, maxHeight: imageHeight)
          .padding([.leading, .trailing], imageSidesPadding)
        Text(mealItem.strMeal)
          .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
          .padding([.top], bottomPadding)
          .font(.custom(uberFontString, size: mainTitleFontSize))
        if let mealItem: MealDetail = viewModel.mealDetail {
          Text(ingredientsString)
            .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
            .font(.custom(uberFontString, size: subtitleFontSize))
          ingredientsVStack()
          Text(instructionsString)
            .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
            .padding([.top, .bottom], bottomPadding)
            .font(.custom(uberFontString, size: subtitleFontSize))
          Text(mealItem.strInstructions ?? String())
            .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
            .font(.custom(uberFontString, size: instructionsFontSize))
        }
      }
      .padding()
    }
  }

  func ingredientsVStack() -> some View {
    VStack(spacing: CGFloat.zero) {
      ForEach(viewModel.mealIngredients) { ingredient in
        MealDetailIngredientView(ingredient: ingredient)
      }
    }
  }
}
