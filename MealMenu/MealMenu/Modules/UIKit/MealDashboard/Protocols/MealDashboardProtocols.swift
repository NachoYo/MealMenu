//
//  MealDashboardProtocols.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

protocol MealDashboardViewProtocol: UIViewController {
  var presenter: MealDashboardPresenterProtocol? { get set }
  var mainCollectionView: UICollectionView? { get }
  func loadCollectionView()
  func reloadCollectionView()
}

protocol MealDashboardWireFrameProtocol {
  static func presentMealDashboardModule(mealCategory: String) -> UIViewController
}

protocol MealDashboardPresenterProtocol: AnyObject {
  var view: MealDashboardViewProtocol? { get set }
  var interactor: MealDashboardInteractorProtocol? { get set }
  var wireFrame: MealDashboardWireFrameProtocol? { get set }
  func viewDidLoad()
  func getMealCategoryName() -> String
  func getNumberOfCategories() -> Int
  func getMealCell(index: Int) -> UICollectionViewCell
  func didFetchCatalog(list: MealList)
  func failedCatalogFetch()
  func getMealItem(index: Int) -> MealItem?
  func getMealCategoryImage(idCategory: String) -> UIImage?
}

protocol MealDashboardInteractorProtocol {
  var presenter: MealDashboardPresenterProtocol? { get set }
  var APIDataManager: MealDashboardAPIDataManagerProtocol? { get set }
  func fetchMeals(mealCategory: String)
  func fetchMealImages(list: MealList, completionHandler: @escaping ([String: UIImage?]) -> Void)
}

protocol MealDashboardAPIDataManagerProtocol {
  func fetchMealsCatalog(mealCategory: String, completionHandler: @escaping (APIServiceResult<MealList, APIServiceError>) -> Void)
  func fetchMealImage(downloadURL: String, completionHandler: @escaping (Data?) -> Void)
}
