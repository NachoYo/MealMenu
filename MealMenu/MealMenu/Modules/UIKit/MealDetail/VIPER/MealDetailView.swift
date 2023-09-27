//
//  CategoryDashboardView.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDetailViewController: UIViewController, MealDetailViewProtocol {

  // MARK: - VIPER Variables
  var presenter: MealDetailPresenterProtocol?

  // MARK: - Variables
  var mainCollectionView: UICollectionView?
  var mealDetailHeaderCellId: String = "MealDetailHeaderCell"
  var simpleImageViewCellId: String = "SimpleImageViewCell"
  var mealDetailIngredientCellId: String = "MealDetailIngredientCell"

  // MARK: - UIViewController Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = presenter?.getMealName() ?? "Meal"
    self.presenter?.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = false
  }

  // MARK: - Presenter -> View Functions
  func loadCollectionView() {
    self.generateUI()
  }

  func reloadCollectionView() {
    mainCollectionView?.reloadData()
  }

  // MARK: - UI Functions
  private func generateUI() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    myCollectionView.backgroundColor = UIColor.white
    myCollectionView.dataSource = self
    myCollectionView.delegate = self
    myCollectionView.register(MealDetailHeaderCell.self, forCellWithReuseIdentifier: mealDetailHeaderCellId)
    myCollectionView.register(SimpleImageViewCell.self, forCellWithReuseIdentifier: simpleImageViewCellId)
    myCollectionView.register(MealDetailIngredientCell.self, forCellWithReuseIdentifier: mealDetailIngredientCellId)

    myCollectionView.showsVerticalScrollIndicator = false
    myCollectionView.backgroundColor = UIColor.white
    mainCollectionView = myCollectionView
    addConstraints()
  }

  func addConstraints() {
    guard let mainCollectionView: UICollectionView = mainCollectionView
    else {
      return
    }
    view.addSubview(mainCollectionView)
    NSLayoutConstraint.activate([
      mainCollectionView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainCollectionView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      mainCollectionView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      mainCollectionView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}

// MARK: - UICollectionView Functions
extension MealDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.getNumberOfCells() ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = presenter?.getCell(index: indexPath.item)
    return cell ?? UICollectionViewCell()
  }
}

extension MealDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellHeight: CGFloat = presenter?.getCellHeight(index: indexPath.item) ?? 0.0
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
}
