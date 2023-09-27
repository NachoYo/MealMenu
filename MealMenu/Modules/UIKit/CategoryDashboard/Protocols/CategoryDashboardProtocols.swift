//
//  CategoryDashboardProtocols.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

protocol CategoryDashboardViewProtocol: UIViewController {
  var presenter: CategoryDashboardPresenterProtocol? { get set }
  var mainCollectionView: UICollectionView? { get }
  func loadCollectionView()
  func reloadCollectionView()
}

protocol CategoryDashboardWireFrameProtocol {
  static func presentCategoryDashboardModule() -> UIViewController
}

protocol CategoryDashboardPresenterProtocol: AnyObject {
  var view: CategoryDashboardViewProtocol? { get set }
  var interactor: CategoryDashboardInteractorProtocol? { get set }
  var wireFrame: CategoryDashboardWireFrameProtocol? { get set }
  func viewDidLoad()
  func getNumberOfCategories() -> Int
  func getCategoryCell(index: Int) -> UICollectionViewCell
  func getMealCategory(index: Int) -> MealCategory?
  func didFetchCatalog(catalog: MealCategoryCatalog)
  func failedCatalogFetch()
}

protocol CategoryDashboardInteractorProtocol {
  var presenter: CategoryDashboardPresenterProtocol? { get set }
  var APIDataManager: CategoryDashboardAPIDataManagerProtocol? { get set }
  func fetchCategories()
  func fetchCategoryImages(catalog: MealCategoryCatalog, completionHandler: @escaping ([String: UIImage?]) -> Void)
}

protocol CategoryDashboardAPIDataManagerProtocol {
  func fetchCategoryService(completionHandler: @escaping (APIServiceResult<MealCategoryCatalog, APIServiceError>) -> Void)
  func fetchCategoryImage(downloadURL: String, completionHandler: @escaping (Data?) -> Void)
}
