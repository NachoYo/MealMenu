//
//  RemoteImage.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI

struct RemoteImage: View, Identifiable {

  // MARK: - Initializer
  init(url: String) {
    imageLoader = ImageLoader(url: url)
  }

  // MARK: - Variables
  public var id: UUID {
    return UUID()
  }
  @ObservedObject var imageLoader: ImageLoader

  // MARK: - View
  var body: some View {
    if let image: UIImage = imageLoader.image {
      Image(uiImage: image)
        .resizable()
    } else {
      ProgressView()
    }
  }
}
