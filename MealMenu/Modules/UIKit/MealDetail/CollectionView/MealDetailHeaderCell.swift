//
//  MealDetailHeaderCell.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 24/09/23.
//

import UIKit

class MealDetailHeaderCell: UICollectionViewCell {

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Variables
  let mainLabel: UILabel = UILabel()
  let uberFontString: String = "UberMoveMedium"

  // MARK: - Functions
  func addViews(){
    addSubview(mainLabel)
    mainLabel.clipsToBounds = true
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.textColor = .black
    mainLabel.numberOfLines = 0
    mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
  }

  func setupUI(titleText: String?, fontSize: CGFloat) {
    mainLabel.text = titleText
    mainLabel.font = UIFont(name: uberFontString, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
  }
}
