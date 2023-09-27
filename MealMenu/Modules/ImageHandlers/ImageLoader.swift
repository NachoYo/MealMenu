//
//  ImageLoader.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {

  // MARK: - Initializer
  init(url: String) {
    self.url = url
    loadImage()
  }

  // MARK: - Variables
  @Published var image: UIImage?
  @Published var loadedImage: Bool = false

  private var url: String
  private var task: URLSessionDataTask?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  // MARK: - Functions
  private func loadImage() {
    if let cachedImage: UIImage = ImageCache.shared.get(forKey: url) {
      self.image = cachedImage
      loadedImage = true
      return
    }
    let apiClient: APIClient = APIClient()
    let cancellable: AnyPublisher<Data, APIServiceError>
    cancellable = apiClient.directDownload(downloadPath: url)
    cancellable.receive(on: DispatchQueue.main)
      .sink { _ in
        // Error
      } receiveValue: { data in
        let image: UIImage? = UIImage(data: data)
        self.image = image
        ImageCache.shared.set(image!, forKey: self.url)
        self.loadedImage = true
      }
      .store(in: &cancellables)
  }
}
