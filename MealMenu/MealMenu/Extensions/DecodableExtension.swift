//
//  DecodableExtension.swift
//  MealMenuTests
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import Foundation

extension Decodable {
  init<Key: Hashable>(_ dict: [Key: Any]) throws
  {
    let data: Data = try JSONSerialization.data(withJSONObject: dict, options: [])
    self = try JSONDecoder().decode(Self.self, from: data)
  }
}
