//
//  CategoryDashboardPresenter.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDetailPresenter: MealDetailPresenterProtocol {

  // MARK: - Initializer
  public init(mealItem: MealItem, image: UIImage?) {
    self.mealItem = mealItem
    self.mealImage = image
  }

  // MARK: - VIPER Variables
  weak var view: MealDetailViewProtocol?
  var interactor: MealDetailInteractorProtocol?
  var wireFrame: MealDetailWireFrameProtocol?

  // MARK: - Variables
  private var cellsDictionary: [Int: UICollectionViewCell] = [:]
  private var cellsHeights: [Int: CGFloat] = [:]
  private var cellsCount: Int = 0
  private var mealImage: UIImage?
  var mealDetail: MealDetail?
  var mealItem: MealItem

  // MARK: - UI Constants
  let uberFontString: String = "UberMoveMedium"

  // MARK: - View -> Presenter Functions
  func viewDidLoad() {
    interactor?.fetchMealDetail(idMeal: mealItem.idMeal)
  }

  func getMealName() -> String {
    return self.mealItem.strMeal
  }

  func getNumberOfCells() -> Int {
    return cellsCount + 1
  }

  func getCell(index: Int) -> UICollectionViewCell? {
    return cellsDictionary[index]
  }

  func getCellHeight(index: Int) -> CGFloat {
    return cellsHeights[index] ?? 0.0
  }

  func getMealImage(idCategory: String) -> UIImage? {
    return self.mealImage
  }

  // MARK: - Interactor -> Presenter Functions
  func didFetchMealDetail(mealDetail: MealDetail) {
    self.mealDetail = mealDetail
    self.view?.loadCollectionView()
    generateCells()
  }

  func failedMealDetailFetch() {
    // Error
  }

  private func generateCells() {
    guard let mealDetail: MealDetail = mealDetail
    else {
      return
    }
    if let imageCell: SimpleImageViewCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: "SimpleImageViewCell", for: IndexPath(item: 0, section: 0)) as? SimpleImageViewCell {
      imageCell.setupUI(image: mealImage)
      cellsDictionary[0] = imageCell
      cellsHeights[0] = 250.0
    }
    if let mealNameCell: MealDetailHeaderCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: "MealDetailHeaderCell", for: IndexPath(item: 0, section: 0)) as? MealDetailHeaderCell {
      mealNameCell.setupUI(titleText: mealItem.strMeal, fontSize: 26.0)
      cellsDictionary[1] = mealNameCell
      cellsHeights[1] = getRequiredHeight(text: mealItem.strMeal, fontSize: 26) + 4
    }
    cellsCount = 1

    if let mealDetailDictionary = try? mealDetail.asDictionary(),
       let informationSubtitleCell: MealDetailHeaderCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: "MealDetailHeaderCell", for: IndexPath(item: 0, section: 0)) as? MealDetailHeaderCell{

      informationSubtitleCell.setupUI(titleText: "Ingredients", fontSize: 22.0)
      cellsCount += 1
      cellsDictionary[cellsCount] = informationSubtitleCell
      cellsHeights[cellsCount] = 42.0

      for index in 1...20 {
        let ingredientKey = "strIngredient\(index)"
        let ingredientSizeKey = "strMeasure\(index)"
        if let ingredient: String = mealDetailDictionary[ingredientKey] as? String,
           ingredient != "",
           ingredient != " ",
           let ingredientCell: MealDetailIngredientCell = view?.mainCollectionView?.dequeueReusableCell(
            withReuseIdentifier: "MealDetailIngredientCell",
            for: IndexPath(item: 0, section: 0)
           ) as? MealDetailIngredientCell {
          let ingredientSize = mealDetailDictionary[ingredientSizeKey] as? String
          ingredientCell.setupUI(
            ingredientText: ingredient,
            ingredientSizeText: ingredientSize,
            fontSize: 18.0)
          cellsCount += 1
          cellsDictionary[cellsCount] = ingredientCell
          cellsHeights[cellsCount] = 42.0
        }
      }
    }
    if let mealDetail: MealDetail = self.mealDetail,
       let mealInstructions: String = mealDetail.strInstructions,
       let instructionsSubtitleCell: MealDetailHeaderCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: "MealDetailHeaderCell", for: IndexPath(item: 0, section: 0)) as? MealDetailHeaderCell,
       let mealInstructionsCell: MealDetailHeaderCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: "MealDetailHeaderCell", for: IndexPath(item: 0, section: 0)) as? MealDetailHeaderCell
    {
      instructionsSubtitleCell.setupUI(titleText: "Instructions", fontSize: 22.0)
      mealInstructionsCell.setupUI(titleText: mealInstructions, fontSize: 16.0)
      cellsCount += 1
      cellsDictionary[cellsCount] = instructionsSubtitleCell
      cellsHeights[cellsCount] = 42.0
      cellsCount += 1
      cellsDictionary[cellsCount] = mealInstructionsCell
      cellsHeights[cellsCount] = getRequiredHeight(text: mealInstructions, fontSize: 16.0)
    }
    view?.reloadCollectionView()
  }

  func getRequiredHeight(text: String, fontSize: CGFloat) -> CGFloat {
    let label = UILabel(frame: CGRect(x: CGFloat.zero, y: CGFloat.zero, width: UIScreen.main.bounds.width - 70, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont(name: uberFontString, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    label.text = text
    label.sizeToFit()
    return label.frame.height
  }
}
