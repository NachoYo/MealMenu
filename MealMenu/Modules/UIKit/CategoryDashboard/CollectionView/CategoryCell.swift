//
//  CategoryDashboardView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {

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
  let uiLabel: UILabel = UILabel()
  let uiView: UIView = UIView()
  let labelView: UIView = UIView()

  let uberFontString: String = "UberMoveMedium"

  // MARK: - Functions
  func addViews(){
    addSubview(uiView)
    uiView.clipsToBounds = true
    uiView.translatesAutoresizingMaskIntoConstraints = false
    uiView.contentMode = .scaleAspectFit
    uiView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    uiView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    uiView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    uiView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    uiView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    
    addSubview(uiImageView)
    uiImageView.layer.cornerRadius = 50
    uiImageView.clipsToBounds = true
    uiImageView.translatesAutoresizingMaskIntoConstraints = false
    uiImageView.contentMode = .scaleAspectFill
    uiImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
    uiImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    uiImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
    uiImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true

    addSubview(labelView)
    labelView.layer.cornerRadius = 16
    labelView.alpha = 0.3
    labelView.backgroundColor = .black
    labelView.clipsToBounds = true
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    labelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
    labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true

    addSubview(uiLabel)
    uiLabel.textAlignment = .center
    uiLabel.clipsToBounds = true
    uiLabel.translatesAutoresizingMaskIntoConstraints = false
    uiLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    uiLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    uiLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    uiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
    uiLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
    uiLabel.font = UIFont(name: uberFontString, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    uiLabel.textColor = .white
  }

  func setupUI(category: MealCategory, image: UIImage?) {
    uiImageView.image = image
    uiLabel.text = category.strCategory
    if let image: UIImage = image {
      self.uiView.backgroundColor = image.getPixelColor(pos: CGPoint(x: 100, y: 100))
    }
  }
}
