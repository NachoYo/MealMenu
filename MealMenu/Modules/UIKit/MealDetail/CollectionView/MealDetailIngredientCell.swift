//
//  MealDetailIngredientCell.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 24/09/23.
//

import UIKit

class MealDetailIngredientCell: UICollectionViewCell {

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Variables
  let ingredientLabel: UILabel = UILabel()
  let ingredientSizeLabel: UILabel = UILabel()
  let mainView: UIView = UIView()

  let uberFontString: String = "UberMoveMedium"

  // MARK: - Functions
  func addViews(){
    addSubview(mainView)
    mainView.clipsToBounds = true
    mainView.translatesAutoresizingMaskIntoConstraints = false
    mainView.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
    mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1.0).isActive = true


    mainView.addSubview(ingredientLabel)
    ingredientLabel.clipsToBounds = true
    ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
    ingredientLabel.textColor = .black
    ingredientLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12).isActive = true
    ingredientLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true

    mainView.addSubview(ingredientSizeLabel)
    ingredientSizeLabel.clipsToBounds = true
    ingredientSizeLabel.translatesAutoresizingMaskIntoConstraints = false
    ingredientSizeLabel.textColor = .black
    ingredientSizeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12).isActive = true
    ingredientSizeLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true
  }

  func setupUI(ingredientText: String?, ingredientSizeText: String?, fontSize: CGFloat) {
    ingredientLabel.text = ingredientText
    ingredientLabel.font = UIFont(name: uberFontString, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)

    ingredientSizeLabel.text = ingredientSizeText
    ingredientSizeLabel.font = UIFont(name: uberFontString, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
  }
}
