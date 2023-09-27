//
//  ImageCache.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import UIKit

class ImageCache {

  // MARK: - Singleton Instance
  static let shared: ImageCache = ImageCache()

  // MARK: - Variables
  private var imageCache: NSCache<NSString, UIImage> = {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString,UIImage>()
    cache.countLimit = 200
    cache.totalCostLimit = 1024 * 1024 * 200
    return cache
  }()

  // MARK: - Functions
  func set(_ image: UIImage, forKey key: String) {
    imageCache.setObject(image, forKey: key as NSString)
  }

  func get(forKey key: String) -> UIImage? {
    return imageCache.object(forKey: key as NSString)
  }
}
