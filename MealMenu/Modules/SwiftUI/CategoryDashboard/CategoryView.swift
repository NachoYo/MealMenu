//
//  CategoryView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

struct CategoryView: View {

  // MARK: - Initializer
  public init(category: MealCategory) {
    self.category = category
    let remoteImage: RemoteImage = RemoteImage(url: category.strCategoryThumb)
    self.remoteImage = remoteImage
    self.imageLoader = remoteImage.imageLoader
  }

  // MARK: - Variables
  let category: MealCategory
  var remoteImage: RemoteImage
  @ObservedObject var imageLoader: ImageLoader

  // MARK: - UI Constants
  let imageHeight: CGFloat = 160.0
  let imageCornerRadius: CGFloat = 50.0
  let textHeight: CGFloat = 30.0
  let sidesPadding: CGFloat = 16.0
  let fontSize: CGFloat = 16.0
  let mainTitleFontSize: CGFloat = 26.0
  let viewCornerRadius: CGFloat = 16.0
  let viewOpacity: CGFloat = 0.3
  let lineLimit: Int = 3
  let uberFont: String = "UberMoveMedium"

  // MARK: - Views
  var body: some View {
    ZStack {
      if imageLoader.image != nil {
        RoundedRectangle(cornerRadius: CGFloat.zero)
          .fill(getImageColor())
      } else {
        RoundedRectangle(cornerRadius: CGFloat.zero)
          .fill(.gray)
      }
      VStack {
        remoteImage
          .scaledToFit()
          .frame(height: imageHeight)
          .padding([.leading, .trailing], sidesPadding)
          .cornerRadius(imageCornerRadius)
        ZStack {
          RoundedRectangle(cornerRadius: viewCornerRadius)
            .frame(maxWidth: .infinity, maxHeight: textHeight)
            .padding([.leading, .trailing], sidesPadding)
            .opacity(viewOpacity)
          Text(category.strCategory)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: textHeight)
            .font(.custom(uberFont, size: fontSize))
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Functions
  func getImageColor() -> Color {
    let categoryImage: UIImage = remoteImage.imageLoader.image ?? UIImage()
    guard categoryImage != UIImage() else {
      return Color.gray
    }
    let centerColor: Color = Color(categoryImage.getPixelColor(pos: CGPoint(x: 100, y: 100)) ?? UIColor.gray)
    return centerColor
  }
}
