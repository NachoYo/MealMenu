//
//  CategoryDashboardView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import UIKit

class SimpleImageViewCell: UICollectionViewCell {

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Variables
  let uiImageView: UIImageView = UIImageView()

  // MARK: - Functions
  func addViews(){
    addSubview(uiImageView)
    uiImageView.clipsToBounds = true
    uiImageView.translatesAutoresizingMaskIntoConstraints = false
    uiImageView.contentMode = .scaleAspectFill
    uiImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
    uiImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    uiImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    uiImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
  }

  func setupUI(image: UIImage?) {
    if let image: UIImage = image {
      uiImageView.image = image
    }
  }
}
