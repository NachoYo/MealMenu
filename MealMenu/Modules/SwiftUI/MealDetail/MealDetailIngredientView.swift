//
//  MealDetailIngredientView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

struct MealDetailIngredientView: View {

  // MARK: - Initializer
  public init(ingredient: MealIngredient) {
    self.ingredient = ingredient
  }

  // MARK: - Variables
  let ingredient: MealIngredient

  // MARK: - UI Constants
  let sidesPadding: CGFloat = 16.0
  let textHeight: CGFloat = 42.0
  let fontSize: CGFloat = 18.0
  let uberFontString: String = "UberMoveMedium"

  // MARK: - Views
  var body: some View {
    HStack {
      Text(ingredient.ingredientName)
        .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .leading)
        .padding(.leading, sidesPadding)
        .font(.custom(uberFontString, size: fontSize))
      Text(ingredient.ingredientMeasure ?? "")
        .frame(maxWidth: .infinity, minHeight: textHeight, alignment: .trailing)
        .padding(.trailing, sidesPadding)
        .font(.custom(uberFontString, size: fontSize))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 239 / 255, green: 239 / 255, blue: 244 / 255))
  }
}
