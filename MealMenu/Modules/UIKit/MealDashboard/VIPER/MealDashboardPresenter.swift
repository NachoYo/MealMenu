//
//  CategoryDashboardPresenter.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDashboardPresenter: MealDashboardPresenterProtocol {

  // MARK: - VIPER Variables
  weak var view: MealDashboardViewProtocol?
  var interactor: MealDashboardInteractorProtocol?
  var wireFrame: MealDashboardWireFrameProtocol?

  // MARK: - Variables
  private var list: MealList?
  private var imageCatalog: [String: UIImage?]?
  private var categoryCells: [UICollectionViewCell] = []
  private let mealCategory: String

  let mealCellId = "MealCell"

  // MARK: - Initializer
  public init(mealCategory: String) {
    self.mealCategory = mealCategory
  }

  // MARK: - View -> Presenter Functions
  func viewDidLoad() {
    interactor?.fetchMeals(mealCategory: mealCategory)
  }

  func getMealCategoryName() -> String {
    return self.mealCategory
  }

  func getNumberOfCategories() -> Int {
    return categoryCells.count
  }

  func getMealCell(index: Int) -> UICollectionViewCell {
    guard index < categoryCells.count else {
      return UICollectionViewCell()
    }
    return categoryCells[index]
  }

  func getMealItem(index: Int) -> MealItem? {
    guard let list: MealList = list,
          index < list.meals.count else {
      return nil
    }
    return list.meals[index]
  }

  func getMealCategoryImage(idCategory: String) -> UIImage? {
    return imageCatalog?[idCategory] ?? nil
  }

  // MARK: - Interactor -> Presenter Functions
  func didFetchCatalog(list: MealList) {
    self.list = list
    interactor?.fetchMealImages(list: list, completionHandler: { imageCatalog in
      self.imageCatalog = imageCatalog
      self.view?.loadCollectionView()
      self.generateCategoryCells()
    })
  }

  func failedCatalogFetch() {
    // Error
  }

  private func generateCategoryCells() {
    guard let list: MealList = list
    else {
      return
    }
    for index in 0...list.meals.count - 1 {
      if let cell: MealCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: mealCellId, for: IndexPath(item: index, section: 0)) as? MealCell {
        let image: UIImage? = getMealCategoryImage(idCategory: list.meals[index].idMeal)
        cell.setupUI(meal: list.meals[index], image: image)
        categoryCells.append(cell)
      }
    }
    view?.reloadCollectionView()
  }
}
