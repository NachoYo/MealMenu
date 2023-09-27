//
//  UIImageExtension.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 16/09/23.
//
import UIKit

extension UIImage {
  func getPixelColor(pos: CGPoint) -> UIColor? {
    let pixelData: CFData? = self.cgImage?.dataProvider?.data
    let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

    let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

    let r: CGFloat = CGFloat(data[pixelInfo]) / CGFloat(255.0)
    let g: CGFloat = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
    let b: CGFloat = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
    let a: CGFloat = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
}
