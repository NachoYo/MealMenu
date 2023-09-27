//
//  EncodableExtension.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 24/09/23.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data: Data = try JSONEncoder().encode(self)
    guard let dictionary: [String : Any] = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
