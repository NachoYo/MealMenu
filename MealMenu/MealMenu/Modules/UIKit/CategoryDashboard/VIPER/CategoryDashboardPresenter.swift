//
//  CategoryDashboardPresenter.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class CategoryDashboardPresenter: CategoryDashboardPresenterProtocol {

  // MARK: - VIPER Variables
  weak var view: CategoryDashboardViewProtocol?
  var interactor: CategoryDashboardInteractorProtocol?
  var wireFrame: CategoryDashboardWireFrameProtocol?

  // MARK: - Variables
  private var catalog: MealCategoryCatalog?
  private var imageCatalog: [String: UIImage?]?
  private var categoryCells: [UICollectionViewCell] = []

  let categoryCellId = "CategoryCell"

  // MARK: - View -> Presenter Functions
  func viewDidLoad() {
    interactor?.fetchCategories()
  }
  func getNumberOfCategories() -> Int {
    return categoryCells.count
  }
  func getCategoryCell(index: Int) -> UICollectionViewCell {
    guard index < categoryCells.count else {
      return UICollectionViewCell()
    }
    return categoryCells[index]
  }

  func getMealCategory(index: Int) -> MealCategory? {
    guard let catalog: MealCategoryCatalog = catalog,
          index < catalog.categories.count else {
      return nil
    }
    return catalog.categories[index]
  }

  func getMealCategoryImage(idCategory: String) -> UIImage? {
    return imageCatalog?[idCategory] ?? nil
  }

  // MARK: - Interactor -> Presenter Functions
  func didFetchCatalog(catalog: MealCategoryCatalog) {
    self.catalog = catalog
    interactor?.fetchCategoryImages(catalog: catalog, completionHandler: { imageCatalog in
      self.imageCatalog = imageCatalog
      self.view?.loadCollectionView()
      self.generateCategoryCells()
    })
  }

  func failedCatalogFetch() {
    // Error
  }

  private func generateCategoryCells() {
    guard let catalog: MealCategoryCatalog = catalog
    else {
      return
    }
    for index in 0...catalog.categories.count - 1 {
      if let cell: CategoryCell = view?.mainCollectionView?.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: IndexPath(item: index, section: 0)) as? CategoryCell {
        let image: UIImage? = getMealCategoryImage(idCategory: catalog.categories[index].idCategory)
        cell.setupUI(category: catalog.categories[index], image: image)
        categoryCells.append(cell)
      }
    }
    view?.reloadCollectionView()
  }

}
