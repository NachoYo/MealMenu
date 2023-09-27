//
//  MealDetailProtocols.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

protocol MealDetailViewProtocol: UIViewController {
  var presenter: MealDetailPresenterProtocol? { get set }
  var mainCollectionView: UICollectionView? { get }
  func loadCollectionView()
  func reloadCollectionView()
}

protocol MealDetailWireFrameProtocol {
  static func presentMealDetailModule(meal: MealItem, image: UIImage?) -> UIViewController
}

protocol MealDetailPresenterProtocol: AnyObject {
  var view: MealDetailViewProtocol? { get set }
  var interactor: MealDetailInteractorProtocol? { get set }
  var wireFrame: MealDetailWireFrameProtocol? { get set }
  func viewDidLoad()
  func getMealName() -> String
  func getNumberOfCells() -> Int
  func getCellHeight(index: Int) -> CGFloat
  func getCell(index: Int) -> UICollectionViewCell?
  func didFetchMealDetail(mealDetail: MealDetail)
  func failedMealDetailFetch()
}

protocol MealDetailInteractorProtocol {
  var presenter: MealDetailPresenterProtocol? { get set }
  var APIDataManager: MealDetailAPIDataManagerProtocol? { get set }
  func fetchMealDetail(idMeal: String)
}

protocol MealDetailAPIDataManagerProtocol {
  func fetchMealDetailService(idMeal: String, completionHandler: @escaping (APIServiceResult<MealDetailArray, APIServiceError>) -> Void)
}
